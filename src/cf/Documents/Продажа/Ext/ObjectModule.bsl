﻿
Перем РежимЗаписиДокументаПродажи;


Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	СуммаПоДокументу = Товары.Итог("Сумма") + Услуги.Итог("Сумма");
	РежимЗаписиДокументаПродажи = РежимЗаписи;
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, Режим)
	// регистр ПартииТоваров Приход
	_Запрос = Новый Запрос;
	_Запрос.Текст =
		"ВЫБРАТЬ
		|	ПродажаТовары.Номенклатура,
		|	СУММА(ПродажаТовары.Количество) КАК Количество,
		|	СУММА(ПродажаТовары.Сумма) КАК Сумма
		|ПОМЕСТИТЬ втПродажа
		|ИЗ
		|	Документ.Продажа.Товары КАК ПродажаТовары
		|ГДЕ
		|	ПродажаТовары.Ссылка = &Ссылка
		|
		|СГРУППИРОВАТЬ ПО
		|	ПродажаТовары.Номенклатура
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ПартииТоваровОстатки.Номенклатура,
		|	втПродажа.Количество - ПартииТоваровОстатки.КоличествоОстаток КАК НеХватает
		|ИЗ
		|	РегистрНакопления.ПартииТоваров.Остатки(
		|			&МоментВремени,
		|			Номенклатура В
		|				(ВЫБРАТЬ
		|					втПродажа.Номенклатура
		|				ИЗ
		|					втПродажа)) КАК ПартииТоваровОстатки
		|		ЛЕВОЕ СОЕДИНЕНИЕ втПродажа КАК втПродажа
		|		ПО ПартииТоваровОстатки.Номенклатура = втПродажа.Номенклатура
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ПартииТоваровОстатки.Партия КАК Партия,
		|	ПартииТоваровОстатки.Номенклатура КАК Номенклатура,
		|	ПартииТоваровОстатки.КоличествоОстаток КАК КоличествоОстаток,
		|	втПродажа.Количество КАК Количество,
		|	втПродажа.Сумма КАК Сумма
		|ИЗ
		|	РегистрНакопления.ПартииТоваров.Остатки(
		|			&МоментВремени,
		|			Номенклатура В
		|				(ВЫБРАТЬ
		|					втПродажа.Номенклатура
		|				ИЗ
		|					втПродажа)) КАК ПартииТоваровОстатки
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ втПродажа КАК втПродажа
		|		ПО ПартииТоваровОстатки.Номенклатура = втПродажа.Номенклатура
		|
		|УПОРЯДОЧИТЬ ПО
		|	Партия
		|ИТОГИ
		|	СУММА(КоличествоОстаток),
		|	МАКСИМУМ(Количество),
		|	МАКСИМУМ(Сумма)
		|ПО
		|	Номенклатура
		|АВТОУПОРЯДОЧИВАНИЕ";

	_Запрос.УстановитьПараметр("Ссылка", Ссылка);
	_Запрос.УстановитьПараметр("МоментВремени", МоментВремени());

	РезультатПакет = _Запрос.ВыполнитьПакет();

	Если РезультатПакет[1].Пустой() Тогда
		Отказ = Истина;
		Сообщить("Нет остатков");
		Возврат;
	КонецЕсли;

	Выборка = РезультатПакет[1].Выбрать();
	Пока Выборка.Следующий() Цикл
		Если Выборка.НеХватает > 0 Тогда
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = "Товара """ + Выборка.Номенклатура + """ не хватает в количестве " + Выборка.НеХватает;
			Сообщение.УстановитьДанные(ЭтотОбъект);
			Сообщение.Сообщить();
			//Сообщить("Товара """ + Выборка.Номенклатура + """ не хватает в количестве " + Выборка.НеХватает);
			Отказ = Истина;
		КонецЕсли;
	КонецЦикла;

	Если Отказ Тогда Возврат; КонецЕсли;

	Движения.ПартииТоваров.Записывать = Истина;
	Движения.Продажи.Записывать = Истина;

	ВыборкаНоменклатура = РезультатПакет[2].Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам, "Номенклатура");
	Пока ВыборкаНоменклатура.Следующий() Цикл
		ВыборкаПоПартиям = ВыборкаНоменклатура.Выбрать();
		ОсталосьСписатьКоличество = ВыборкаНоменклатура.Количество;
		Пока ВыборкаПоПартиям.Следующий() И ОсталосьСписатьКоличество <> 0 Цикл
			Списать = Мин(ВыборкаПоПартиям.КоличествоОстаток, ОсталосьСписатьКоличество);

			Движение = Движения.ПартииТоваров.Добавить();
			Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
			Движение.Период = Дата;
			Движение.Партия = ВыборкаПоПартиям.Партия;
			Движение.Номенклатура = ВыборкаПоПартиям.Номенклатура;
			Движение.Количество = Списать;

			ОсталосьСписатьКоличество = ОсталосьСписатьКоличество - Списать;
		КонецЦикла;

		// регистр Продажи
		Движение = Движения.Продажи.Добавить();
		Движение.Период = Дата;
		Движение.Номенклатура = ВыборкаНоменклатура.Номенклатура;
		Движение.Клиент = Покупатель;
		Движение.Количество = ВыборкаНоменклатура.Количество;
		Движение.Сумма = ВыборкаНоменклатура.Сумма;
		Движение.Акция = Акция;
	КонецЦикла;
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	Если РежимЗаписиДокументаПродажи = РежимЗаписиДокумента.Проведение Тогда
		МодульЗакрытиеМесяца.УстановитьАктуальностьРасчетаСебестоимостиПоПроводимомуДокументу(Дата);
	КонецЕсли;	
КонецПроцедуры
