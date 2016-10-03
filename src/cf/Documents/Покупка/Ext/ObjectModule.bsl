﻿
Перем РежимЗаписиДокументаПродажи;


Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	СуммаПоДокументу = Товары.Итог("Сумма") + ЗатратыНаАкции.Итог("Сумма");
	РежимЗаписиДокументаПродажи = РежимЗаписи;
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, Режим)
	//{{__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!

	// регистр ПартииТоваров Приход
	Движения.ПартииТоваров.Записывать = Истина;
	Для Каждого ТекСтрокаТовары Из Товары Цикл
		Движение = Движения.ПартииТоваров.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Период = Дата;
		Движение.Партия = Ссылка;
		Движение.Номенклатура = ТекСтрокаТовары.Номенклатура;
		Движение.Количество = ТекСтрокаТовары.Количество;
	КонецЦикла;

	//}}__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	Если РежимЗаписиДокументаПродажи = РежимЗаписиДокумента.Проведение Тогда
		МодульЗакрытиеМесяца.УстановитьАктуальностьРасчетаСебестоимостиПоПроводимомуДокументу(Дата);
	КонецЕсли;	
КонецПроцедуры