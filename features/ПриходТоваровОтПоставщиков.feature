﻿# encoding: utf-8
# language: ru

@tree

Функционал: Приход товаров от поставщиков
	Как оператор
	Хочу документ для фиксирования данных о количестве, цене и сумме приобретенных компанией товаров
	Чтобы осуществлять прием товаров поставщиков в системе

Контекст: 
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Покупка номенклатуры
	Допустим я подготавливаю вспомогательные данные
	Когда когда я создаю покупку
		Когда В панели разделов я выбираю "Покупки"
		И     В панели функций я выбираю "Покупки"
		Тогда открылось окно "Покупки"
		И     я нажимаю на кнопку "Создать"
		Тогда открылось окно "Покупка (создание)"
	И Я заполняю шапку документа
		Когда в поле "Номер" я ввожу текст ""
		Тогда открылось окно "1С:Предприятие"
		И     я нажимаю на кнопку "Да"
		Тогда открылось окно "Покупка (создание)"
		И     в поле "Номер" я ввожу текст "TEST00000"
		И     я открываю выпадающий список "Поставщик"
		И     я выбираю значение реквизита "Поставщик" из формы списка
		Тогда открылось окно "Клиенты"
		И     я нажимаю на кнопку "Список"
		И     В форме "Клиенты" в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование' |
		| '000000007' | 'ГК "Успех"'   |
		И     я нажимаю на кнопку "Выбрать"
	И Я выбираю номенклатуру
		Когда открылось окно "Покупка (создание) *"
		И     в ТЧ "Товары" я нажимаю на кнопку "Добавить"
		И     в ТЧ "Товары" я выбираю значение реквизита "Номенклатура" из формы списка
		Тогда открылось окно "Номенклатура"
		И     я нажимаю на кнопку "Список"
		И     В форме "Номенклатура" в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование' |
		| '000000006' | 'Флешка 8 ГБ'  |
		И     я нажимаю на кнопку "Выбрать"
		Тогда открылось окно "Покупка (создание) *"
		И     в ТЧ "Товары" я активизирую поле "Количество"
		И     в ТЧ "Товары" в поле "Количество" я ввожу текст "3,000"
		И     в ТЧ "Товары" я активизирую поле "Цена"
		И     в ТЧ "Товары" в поле "Цена" я ввожу текст "500,00"
		И     В форме "Покупка (создание) *" в ТЧ "Товары" я завершаю редактирование строки
		И     в ТЧ "Товары" я нажимаю на кнопку "Добавить"
		И     в ТЧ "Товары" я выбираю значение реквизита "Номенклатура" из формы списка
		Тогда открылось окно "Номенклатура"
		И     я нажимаю на кнопку "Список"
		И     В форме "Номенклатура" в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование'       |
		| '000000007' | 'Аккумулятор Li-On'  |
		И     я нажимаю на кнопку "Выбрать"
		Тогда открылось окно "Покупка (создание) *"
		И     в ТЧ "Товары" я активизирую поле "Количество"
		И     в ТЧ "Товары" в поле "Количество" я ввожу текст "5,000"
		И     в ТЧ "Товары" я активизирую поле "Цена"
		И     в ТЧ "Товары" в поле "Цена" я ввожу текст "400,00"
		И     В форме "Покупка (создание) *" в ТЧ "Товары" я завершаю редактирование строки
	И Я провожу документ
		Когда открылось окно "Покупка (создание) *"
		И     я нажимаю на кнопку "Провести"
		И     Пауза 2
	Тогда результат проведения корректен
		Когда открылось окно "Покупка TEST00000 от *"
		И     В текущем окне я нажимаю кнопку командного интерфейса "Партии товаров"
		Тогда таблица формы с именем "Список" стала равной:
			| 'Период' | 'Номенклатура'      | 'Количество' | 'Регистратор' | 'Номер строки' | 'Партия' |
			| *        | 'Флешка 8 ГБ'       | '3,00'       | *             | '1'            | *        |
			| *        | 'Аккумулятор Li-On' | '5,00'       | *             | '2'            | *        |
		И     Пауза 2
		И     Я закрыл все окна клиентского приложения
		И     Удалить документ типа "Покупка" с номером "TEST00000"