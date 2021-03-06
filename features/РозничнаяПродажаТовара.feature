﻿# encoding: utf-8
# language: ru

@tree

Функционал: Розничная продажа товара
	Как продавец
	Хочу документ, фиксирующий данных о количестве, цене и сумме проданных клиенту товаров
	Чтобы фиксировать в базе данных факт продажи товара клиенту

Контекст: 
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: продажа имеющегося на остатках товара
	Допустим я подготавливаю вспомогательные данные для продажи
	Когда я формирую начальные остатки
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
			И     в поле "Дата" я ввожу текст "16.09.2016 09:37:32"
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
			| '000000002' | 'Флешка 32 ГБ' |
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
			| 'Код'       | 'Наименование' |
			| '000000005' | 'Флешка 16 ГБ' |
			И     я нажимаю на кнопку "Выбрать"
			Тогда открылось окно "Покупка (создание) *"
			И     в ТЧ "Товары" я активизирую поле "Количество"
			И     в ТЧ "Товары" в поле "Количество" я ввожу текст "5,000"
			И     в ТЧ "Товары" я активизирую поле "Цена"
			И     в ТЧ "Товары" в поле "Цена" я ввожу текст "370,00"
			И     В форме "Покупка (создание) *" в ТЧ "Товары" я завершаю редактирование строки
		И Я провожу документ
			Когда открылось окно "Покупка (создание) *"
			И     я нажимаю на кнопку "Провести"
			И     Пауза 2
		Тогда результат проведения корректен
			Когда открылось окно "Покупка TEST00000 от *"
			И     Я закрыл все окна клиентского приложения
	И   я создаю продажу
		Когда В панели разделов я выбираю "Продажи"
		И     В панели функций я выбираю "Продажи"
		Тогда открылось окно "Продажи"
		И     я нажимаю на кнопку "Создать"
		Тогда открылось окно "Продажа (создание)"
	И Я заполняю шапку документа
		Когда в поле "Номер" я ввожу текст ""
		Тогда открылось окно "1С:Предприятие"
		И     я нажимаю на кнопку "Да"
		Тогда открылось окно "Продажа (создание)"
		И     в поле "Номер" я ввожу текст "TEST00000"
		И     в поле "Дата" я ввожу текст "17.09.2016 16:17:18"
		И     я открываю выпадающий список "Покупатель"
		И     я выбираю значение реквизита "Покупатель" из формы списка
		Тогда открылось окно "Клиенты"
		И     я нажимаю на кнопку "Список"
		И     В форме "Клиенты" в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование'         |
		| '000000003' | 'Розничный покупатель' |
		И     я нажимаю на кнопку "Выбрать"
		Тогда открылось окно "Продажа (создание) *"
		И     элемент формы с именем "Акция" стал равен "3 товар в подарок"
	И Я выбираю номенклатуру
		Когда в ТЧ "Товары" я нажимаю на кнопку "Добавить"
		И     в ТЧ "Товары" я выбираю значение реквизита "Номенклатура" из формы списка
		Тогда открылось окно "Номенклатура"
		И     я нажимаю на кнопку "Список"
		И     В форме "Номенклатура" в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование' |
		| '000000002' | 'Флешка 32 ГБ' |
		И     я нажимаю на кнопку "Выбрать"
		Тогда открылось окно "Продажа (создание) *"
		И     в ТЧ "Товары" я активизирую поле "Количество"
		И     в ТЧ "Товары" в поле "Количество" я ввожу текст "1,000"
		И     в ТЧ "Товары" я активизирую поле "Цена"
		И     в ТЧ "Товары" в поле "Цена" я ввожу текст "1 300,00"
		И     В форме "Продажа (создание) *" в ТЧ "Товары" я завершаю редактирование строки
		И     в ТЧ "Товары" я нажимаю на кнопку "Добавить"
		И     в ТЧ "Товары" я выбираю значение реквизита "Номенклатура" из формы списка
		Тогда открылось окно "Номенклатура"
		И     В форме "Номенклатура" в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование' |
		| '000000005' | 'Флешка 16 ГБ' |
		И     я нажимаю на кнопку "Выбрать"
		Тогда открылось окно "Продажа (создание) *"
		И     в ТЧ "Товары" я активизирую поле "Количество"
		И     в ТЧ "Товары" в поле "Количество" я ввожу текст "2,000"
		И     в ТЧ "Товары" я активизирую поле "Цена"
		И     в ТЧ "Товары" в поле "Цена" я ввожу текст "700,00"
		И     В форме "Продажа (создание) *" в ТЧ "Товары" я завершаю редактирование строки
		И     таблица формы с именем "Товары" стала равной:
			| 'N' | 'Сумма'    | 'Цена'     | 'Номенклатура' | 'Количество' |
			| '1' | '1 300,00' | '1 300,00' | 'Флешка 32 ГБ' | '1,000'      |
			| '2' | '1 400,00' | '700,00'   | 'Флешка 16 ГБ' | '2,000'      |
	И Я провожу документ
		Когда открылось окно "Продажа (создание) *"
		И     я нажимаю на кнопку "Провести"
		И     Пауза 2
	Тогда результат проведения корректен
		Когда открылось окно "Продажа TEST00000 от *"
		И     В текущем окне я нажимаю кнопку командного интерфейса "Партии товаров"
		Тогда таблица формы с именем "Список" стала равной:
			| 'Период'              | 'Номенклатура' | 'Количество' |
			| '17.09.2016 16:17:18' | 'Флешка 32 ГБ' | '1,00'       |
			| '17.09.2016 16:17:18' | 'Флешка 16 ГБ' | '2,00'       |
		И     В текущем окне я нажимаю кнопку командного интерфейса "Продажи"
		Тогда таблица формы с именем "Список" стала равной:
			| 'Номенклатура' | 'Период'              | 'Количество' | 'Акция'             | 'Сумма'    | 'Клиент'               |
			| 'Флешка 32 ГБ' | '17.09.2016 16:17:18' | '1,000'      | '3 товар в подарок' | '1 300,00' | 'Розничный покупатель' |
			| 'Флешка 16 ГБ' | '17.09.2016 16:17:18' | '2,000'      | '3 товар в подарок' | '1 400,00' | 'Розничный покупатель' |
		И     Пауза 2
		Тогда Я закрыл все окна клиентского приложения
		И     Удалить документ типа "Продажа" с номером "TEST00000"

Сценарий: продажа не имеющегося на остатках в требуемом количестве товара
	Допустим я подготавливаю вспомогательные данные для продажи
	Когда я создаю продажу
		Когда В панели разделов я выбираю "Главное"
		И     В панели разделов я выбираю "Продажи"
		И     В панели функций я выбираю "Продажи"
		Тогда открылось окно "Продажи"
		И     я нажимаю на кнопку "Создать"
		Тогда открылось окно "Продажа (создание)"
	И Я заполняю шапку документа
		Когда в поле "Номер" я ввожу текст ""
		Тогда открылось окно "1С:Предприятие"
		И     я нажимаю на кнопку "Да"
		Тогда открылось окно "Продажа (создание)"
		И     в поле "Номер" я ввожу текст "TEST00000"
		И     в поле "Дата" я ввожу текст "29.09.2016 11:09:59"
		И     элемент формы с именем "Акция" стал равен "Экономь на доставке!"
		И     я открываю выпадающий список "Покупатель"
		И     я выбираю значение реквизита "Покупатель" из формы списка
		Тогда открылось окно "Клиенты"
		И     я нажимаю на кнопку "Список"
		И     В форме "Клиенты" в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование'         |
		| '000000003' | 'Розничный покупатель' |
		И     я нажимаю на кнопку "Выбрать"
		Тогда открылось окно "Продажа (создание) *"
	И Я выбираю номенклатуру
		Когда в ТЧ "Товары" я нажимаю на кнопку "Добавить"
		И     в ТЧ "Товары" я выбираю значение реквизита "Номенклатура" из формы списка
		Тогда открылось окно "Номенклатура"
		И     я нажимаю на кнопку "Список"
		И     В форме "Номенклатура" в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование' |
		| '000000002' | 'Флешка 32 ГБ' |
		И     я нажимаю на кнопку "Выбрать"
		Тогда открылось окно "Продажа (создание) *"
		И     в ТЧ "Товары" я активизирую поле "Количество"
		И     в ТЧ "Товары" в поле "Количество" я ввожу текст "10,000"
		И     в ТЧ "Товары" я активизирую поле "Цена"
		И     в ТЧ "Товары" в поле "Цена" я ввожу текст "1 500,00"
		И     В форме "Продажа (создание) *" в ТЧ "Товары" я завершаю редактирование строки
		И     таблица формы с именем "Товары" стала равной:
			| 'N' | 'Сумма'     | 'Цена'     | 'Номенклатура' | 'Количество' |
			| '1' | '15 000,00' | '1 500,00' | 'Флешка 32 ГБ' | '10,000'     |
	И Я провожу документ
		Когда открылось окно "Продажа (создание) *"
		И     я нажимаю на кнопку "Провести"
	Тогда результат проведения корректен
		Когда открылось окно "1С:Предприятие"
		И     я нажимаю на кнопку "OK"
		Тогда открылось окно "Продажа (создание) *"
		И     Сообщения пользователю должны содержать " не хватает в количестве "
		И     Удалить документ типа "Покупка" с номером "TEST00000"