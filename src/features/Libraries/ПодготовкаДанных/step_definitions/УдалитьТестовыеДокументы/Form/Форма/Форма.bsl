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

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"УдалитьДокументТипаСНомером(Парам01,Парам02)","УдалитьДокументТипаСНомером","Когда Удалить документ типа ""Тип"" с номером ""000000000""");

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
//Когда Удалить документ типа "Тип" с номером "000000000"
//@ЯУдаляюДокументТипаСНомером(Парам01,Парам02)
Процедура УдалитьДокументТипаСНомером(ТипДокумента,НомерДокумента) Экспорт
	ДокументСсылка = утвПолучитьДокументСсылку(ТипДокумента, НомерДокумента);

	УдалитьДокументПоСсылке(ДокументСсылка);
КонецПроцедуры

///////////////////////////////////////////////////

&НаСервере
Функция утвПолучитьДокументСсылку(НаименованиеТипа = "", Номер)
	ПредставлениеПоиска = "";
	ТекстИсключения = "";

	Если Истина
	   И ЗначениеЗаполнено(НаименованиеТипа)
	   И ЗначениеЗаполнено(Номер) Тогда
		ПредставлениеПоиска = "номеру """ + Номер + """ и типу """ + НаименованиеТипа + """";
	Иначе
		Если ПустаяСтрока(НаименованиеТипа) Тогда
			ТекстИсключения = "Не заполнено свойство поиска Тип документа. ";
		КонецЕсли;

		Если ПустаяСтрока(Номер) Тогда
			ТекстИсключения = "Не заполнено свойство поиска Номер документа. ";
		КонецЕсли;

		ВызватьИсключение ТекстИсключения;
	КонецЕсли;

	ТекстИсключения = "Не нашли документ #НаименованиеТипа с номером #НомерДокумента";
	ТекстИсключения = СтрЗаменить(ТекстИсключения, "#НаименованиеТипа", НаименованиеТипа);
	ТекстИсключения = СтрЗаменить(ТекстИсключения, "#НомерДокумента", Номер);

	_Запрос = Новый Запрос;
	_Запрос.Текст =
		"ВЫБРАТЬ
		|	Ссылка
		|ИЗ
		|	Документ." + НаименованиеТипа + "
		|ГДЕ
		|	Номер = &Номер";

	_Запрос.УстановитьПараметр("Номер", Номер);

	Результат = _Запрос.Выполнить();
	Если Результат.Пустой() Тогда ВызватьИсключение ТекстИсключения; КонецЕсли;

	Выборка = Результат.Выбрать();
	Выборка.Следующий();

	Возврат Выборка.Ссылка;
КонецФункции

&НаСервере
Процедура УдалитьДокументПоСсылке(ДокументСсылка)
	ДокументОбъект = ДокументСсылка.ПолучитьОбъект();
	ДокументОбъект.Удалить();
КонецПроцедуры

//окончание текста модуля