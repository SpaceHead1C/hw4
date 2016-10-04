﻿//начало текста модуля

///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯПодготавливаюВспомогательныеДанные()","ЯПодготавливаюВспомогательныеДанные","Допустим я подготавливаю вспомогательные данные");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"СообщенияПользователюДолжныСодержать(Парам01)","СообщенияПользователюДолжныСодержать","И     Сообщения пользователю должны содержать "" не хватает в количестве """);

	Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//Допустим я подготавливаю вспомогательные данные
//@ЯПодготавливаюВспомогательныеДанные()
Процедура ЯПодготавливаюВспомогательныеДанные() Экспорт
	МассивНаименованийСценариев = Новый Массив;
	МассивНаименованийСценариев.Добавить("продажа имеющегося на остатках товара");
	МассивНаименованийСценариев.Добавить("продажа не имеющегося на остатках в требуемом количестве товара");

	СостояниеVanessaBehavior = Ванесса.ПолучитьСостояниеVanessaBehavior();
	Если МассивНаименованийСценариев.Найти(СостояниеVanessaBehavior.ТекущийСценарий.Имя) <> Неопределено Тогда
		ЗагрузитьFixtureИзМакета("Поставщик");
		ЗагрузитьFixtureИзМакета("Номенклатура");
		ЗагрузитьFixtureИзМакета("Акция");
		ЗагрузитьFixtureИзМакета("Покупатель");
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
//Когда я создаю продажу
//@ЯСоздаюПродажу()
Процедура ЯСоздаюПродажу() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

&НаКлиенте
//И Я выбираю номенклатуру
//@ЯВыбираюНоменклатуру()
Процедура ЯВыбираюНоменклатуру() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

&НаКлиенте
//И     Сообщения пользователю должны содержать " не хватает в количестве "
//@СообщенияПользователюДолжныСодержать(Парам01)
Процедура СообщенияПользователюДолжныСодержать(ЧастьСообщенияПользователю) Экспорт
	НайденоИскомоеСообщение = Ложь;
	МассивСообщенийПользователю = КонтекстСохраняемый.ТестовоеПриложение.ПолучитьАктивноеОкно().ПолучитьТекстыСообщенийПользователю();

	Для Каждого ТекстСообщенияПользователю Из МассивСообщенийПользователю Цикл
		Если СтрНайти(ТекстСообщенияПользователю, ЧастьСообщенияПользователю) <> 0 Тогда
			НайденоИскомоеСообщение = Истина;
			Прервать;
		КонецЕсли;
	КонецЦикла;

	Если НЕ НайденоИскомоеСообщение Тогда
		ВызватьИсключение "Не найдено сообщение пользователю, содержащее: """ + ЧастьСообщенияПользователю + """";
	КонецЕсли;
КонецПроцедуры

//////////////////////////////////////////////////

&НаКлиенте
Функция ПолучитьПутьКФайлуОтносительноКаталогаFeatures(ИмяФайлаСРасширением)
	ПутьКФайлу = "";

	СостояниеVanessaBehavior = Ванесса.ПолучитьСостояниеVanessaBehavior();

	ПутьКТекущемуFeatuteФайлу = СостояниеVanessaBehavior.ТекущаяФича.ПолныйПуть;

	ПутьКФайлу = Лев(ПутьКТекущемуFeatuteФайлу, СтрНайти(ПутьКТекущемуFeatuteФайлу, "features") - 1) + ИмяФайлаСРасширением;

	Возврат ПутьКФайлу;
КонецФункции

&НаКлиенте
Процедура ЗагрузитьFixtureИзМакета(ИмяМакета)
	Ванесса.ЗапретитьВыполнениеШагов();

	НачальноеИмяФайла = ПолучитьПутьКФайлуОтносительноКаталогаFeatures("tools\Выгрузка и загрузка данных XML.epf");

	Адрес = "";

	НачатьПомещениеФайла(Новый ОписаниеОповещения("ЗагрузитьFixtureИзМакетаЗавершение", ЭтотОбъект, ИмяМакета), Адрес, НачальноеИмяФайла, Ложь);
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьFixtureИзМакетаЗавершение(УдалосьПоместитьФайл, Адрес, ВыбранноеИмяФайла, ИмяМакета) Экспорт
	ЗагрузитьFixtureИзМакетаЗавершениеНаСервере(Адрес, ИмяМакета);

	Ванесса.ПродолжитьВыполнениеШагов();
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьFixtureИзМакетаЗавершениеНаСервере(Адрес, ИмяМакета)
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла();

	ДвоичныеДанные = ПолучитьИзВременногоХранилища(Адрес);
	ДвоичныеДанные.Записать(ИмяВременногоФайла);

	ВнешняяОбработка = ВнешниеОбработки.Создать(ИмяВременногоФайла, Ложь);

	ИмяВременногоФайла = ПолучитьИмяВременногоФайла();

	Текст = РеквизитФормыВЗначение("Объект").ПолучитьМакет(ИмяМакета).ПолучитьТекст();

	ВременныйДокумент = Новый ТекстовыйДокумент;
	ВременныйДокумент.УстановитьТекст(Текст);
	ВременныйДокумент.Записать(ИмяВременногоФайла, КодировкаТекста.UTF8);

	ВнешняяОбработка.ВыполнитьЗагрузку(ИмяВременногоФайла);
КонецПроцедуры

//окончание текста модуля