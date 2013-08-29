ITG.Yandex.PDD
==============

Обёртки для API Яндекс.Почта для домена [pdd.yandex.ru][] и командлеты на их основе.
[pdd.yandex.ru][]

Версия модуля: **4.2.0**

Функции модуля
--------------

### Contact

#### Обзор [ConvertTo-Contact][]

Преобразует объект в конвейере в объект со свойствами контакта Яндекс.

	ConvertTo-Contact [-Фамилия <String>] [-Имя <String>] [-Отчество <String>] [-День Рождения <DateTime>] [-Рабочий телефон <String>] [-Адрес эл. почты <String>] <CommonParameters>

Подробнее - [ConvertTo-Contact][].

### DefaultEmail

#### Обзор [Set-DefaultEmail][]

Метод (обёртка над Яндекс.API [reg_default_user][]) предназначен для указания ящика,
который будет получать почту при обнаружении в адресе несуществующего на текущий момент
в домене lname.

	Set-DefaultEmail [-DomainName <String>] [-LName] <String> [-WhatIf] [-Confirm] <CommonParameters>

Подробнее - [Set-DefaultEmail][].

### Mailbox

#### Обзор [Edit-Mailbox][]

Метод (обёртка над Яндекс.API [edit_user][]) предназначен для редактирования
сведений о пользователе ящика на "припаркованном" на Яндексе домене.

	Edit-Mailbox [[-DomainName] <String>] [-LName] <String> [-Password] <Object> [[-SecondName] <String>] [[-FirstName] <String>] [[-MiddleName] <String>] [[-Sex] <String>] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

Подробнее - [Edit-Mailbox][].

#### Обзор [Get-Mailbox][]

Метод (обёртка над Яндекс.API [get_domain_users][]) Метод позволяет получить список почтовых ящиков.

	Get-Mailbox [[-DomainName] <String>] [-WhatIf] [-Confirm] <CommonParameters>

Подробнее - [Get-Mailbox][].

#### Обзор [New-Mailbox][]

Метод (обёртка над Яндекс.API [reg_user][]) предназначен для регистрации
нового пользователя (ящика) на "припаркованном" на Яндексе домене.

	New-Mailbox [-DomainName <String>] -LName <String> -Password <Object> [-SecondName <String>] [-FirstName <String>] [-MiddleName <String>] [-Sex <String>] [-Force] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

Подробнее - [New-Mailbox][].

#### Обзор [Remove-Mailbox][]

Метод (обёртка над Яндекс.API [del_user][]) предназначен для удаления
ящика на "припаркованном" на Яндексе домене.

	Remove-Mailbox [-DomainName <String>] [-LName] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

Подробнее - [Remove-Mailbox][].

### MailList

#### Обзор [New-MailList][]

Создание группы рассылки, включающей всех пользователей домена. Обёртка
над [create_general_maillist][].

	New-MailList [-DomainName <String>] -MailListLName <String> [-LName <String>] [-Force] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

Подробнее - [New-MailList][].

#### Обзор [Remove-MailList][]

Метод предназначен для удаления группы рассылки на "припаркованном" на Яндексе домене.
Обёртка для [delete_general_maillist][].

	Remove-MailList [-DomainName <String>] [-MailListLName] <String> [-WhatIf] [-Confirm] <CommonParameters>

Подробнее - [Remove-MailList][].

### MailListMember

#### Обзор [Get-MailListMember][]

Метод (обёртка над Яндекс.API [get_forward_list][]) предназначен для получения
перенаправлений почты для ящика на "припаркованном" на Яндексе домене.

	Get-MailListMember [-DomainName <String>] [-MailListLName] <String> [-WhatIf] [-Confirm] <CommonParameters>

Подробнее - [Get-MailListMember][].

#### Обзор [New-MailListMember][]

Метод (обёртка над Яндекс.API [set_forward][]) предназначен для создания
перенаправлений почты для ящика на "припаркованном" на Яндексе домене.

	New-MailListMember [[-DomainName] <String>] [-MailListLName] <String> [-LName] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

Подробнее - [New-MailListMember][].

#### Обзор [Remove-MailListMember][]

Метод (обёртка над Яндекс.API [delete_forward][]) предназначен для удаления
перенаправлений почты для ящика на "припаркованном" на Яндексе домене.

	Remove-MailListMember [[-DomainName] <String>] [-MailListLName] <String> [-LName] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

Подробнее - [Remove-MailListMember][].

Подробное описание функций модуля
---------------------------------

#### ConvertTo-Contact

Исходный объект должен обладать реквизитами контакта в соостветствии со схемой AD.
Выходной объект уже будет обладать реквизитами контакта, ожидаемыми при импорте
csv файла в ящик на Яндексе.

##### Синтаксис

	ConvertTo-Contact [-Фамилия <String>] [-Имя <String>] [-Отчество <String>] [-День Рождения <DateTime>] [-Рабочий телефон <String>] [-Адрес эл. почты <String>] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры

- `Фамилия <String>`
        Фамилия

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?false

- `Имя <String>`
        Имя

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?false

- `Отчество <String>`
        Отчество

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?false

- `День Рождения <DateTime>`
        дата рождения

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?false

- `Рабочий телефон <String>`
        телефон рабочий

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?false

- `Адрес эл. почты <String>`
        адрес электронной почты

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?false

- `<CommonParameters>`
        Этот командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
        [about_CommonParameters][] (http://go.microsoft.com/fwlink/?LinkID=113216).



##### Примеры использования

1. Пример 1.

		Get-ADUser | ConvertTo-Contact | Export-Csv 'ya.csv';

#### Set-DefaultEmail

Метод позволяет задать почтовый ящик по умолчанию для домена.
Ящик по умолчанию - это ящик, в который приходят все письма на домен, адресованные в
несуществующие на этом домене ящики.

##### Синтаксис

	Set-DefaultEmail [-DomainName <String>] [-LName] <String> [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?false

- `LName <String>`
        имя почтового ящика. Ящик с именем `$LName` должен уже существовать

        Требуется? true
        Позиция? 1
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?false

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `<CommonParameters>`
        Этот командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
        [about_CommonParameters][] (http://go.microsoft.com/fwlink/?LinkID=113216).



##### Примеры использования

1. Пример 1.

		Set-DefaultEmail -DomainName 'csm.nov.ru' -LName 'master';

##### См. также

- [reg_default_user][]

#### Edit-Mailbox

Метод (обёртка над Яндекс.API [edit_user][]) предназначен для редактирования
сведений о пользователе ящика на "припаркованном" на Яндексе домене.

##### Синтаксис

	Edit-Mailbox [[-DomainName] <String>] [-LName] <String> [-Password] <Object> [[-SecondName] <String>] [[-FirstName] <String>] [[-MiddleName] <String>] [[-Sex] <String>] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса

        Требуется? false
        Позиция? 1
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?false

- `LName <String>`
        Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене

        Требуется? true
        Позиция? 2
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?false

- `Password <Object>`
        Пароль к создаваемой учётной записи. Может быть как зашифрованным (SecureString), так и простым текстом
        (String)

        Требуется? true
        Позиция? 3
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?false

- `SecondName <String>`
        Фамилия пользователя

        Требуется? false
        Позиция? 4
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?false

- `FirstName <String>`
        Имя пользователя

        Требуется? false
        Позиция? 5
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?false

- `MiddleName <String>`
        Отчество пользователя

        Требуется? false
        Позиция? 6
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?false

- `Sex <String>`
        Пол пользователя

        Требуется? false
        Позиция? 7
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?false

- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет

        Требуется? false
        Позиция? named
        Значение по умолчанию False
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `<CommonParameters>`
        Этот командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
        [about_CommonParameters][] (http://go.microsoft.com/fwlink/?LinkID=113216).



##### Примеры использования

1. Пример 1.

		Edit-Mailbox -DomainName 'csm.nov.ru' -LName 'test_user' -Password 'testpassword';

##### См. также

- [edit_user][]

#### Get-Mailbox

Метод (обёртка над Яндекс.API [get_domain_users][]) Метод позволяет получить список почтовых ящиков.
Метод возвращает список ящиков в домене, привязанном к токену.

##### Синтаксис

	Get-Mailbox [[-DomainName] <String>] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса

        Требуется? false
        Позиция? 1
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?false

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `<CommonParameters>`
        Этот командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
        [about_CommonParameters][] (http://go.microsoft.com/fwlink/?LinkID=113216).



##### Примеры использования

1. Пример 1.

		Get-Mailbox -DomainName 'csm.nov.ru';

##### См. также

- [get_domain_users][]

#### New-Mailbox

Метод (обёртка над Яндекс.API [reg_user][]) предназначен для регистрации
нового пользователя (ящика) на "припаркованном" на Яндексе домене.

##### Синтаксис

	New-Mailbox [-DomainName <String>] -LName <String> -Password <Object> [-SecondName <String>] [-FirstName <String>] [-MiddleName <String>] [-Sex <String>] [-Force] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?false

- `LName <String>`
        Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене

        Требуется? true
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?false

- `Password <Object>`
        Пароль к создаваемой учётной записи. Может быть как зашифрованным (SecureString), так и простым текстом
        (String)

        Требуется? true
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?false

- `SecondName <String>`
        Фамилия пользователя

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?false

- `FirstName <String>`
        Имя пользователя

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?false

- `MiddleName <String>`
        Отчество пользователя

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?false

- `Sex <String>`
        Пол пользователя

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?false

- `Force [<SwitchParameter>]`
        перезаписывать ли реквизиты существующих ящиков

        Требуется? false
        Позиция? named
        Значение по умолчанию False
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет

        Требуется? false
        Позиция? named
        Значение по умолчанию False
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `<CommonParameters>`
        Этот командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
        [about_CommonParameters][] (http://go.microsoft.com/fwlink/?LinkID=113216).



##### Примеры использования

1. Пример 1.

		New-Mailbox -DomainName 'csm.nov.ru' -LName 'test_user' -Password 'testpassword';

##### См. также

- [reg_user][]

#### Remove-Mailbox

Метод (обёртка над Яндекс.API [del_user][]) предназначен для удаления
ящика на "припаркованном" на Яндексе домене.

##### Синтаксис

	Remove-Mailbox [-DomainName <String>] [-LName] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `LName <String>`
        Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене

        Требуется? true
        Позиция? 1
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByValue)
        Принимать подстановочные знаки?false

- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет

        Требуется? false
        Позиция? named
        Значение по умолчанию False
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `<CommonParameters>`
        Этот командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
        [about_CommonParameters][] (http://go.microsoft.com/fwlink/?LinkID=113216).



##### Примеры использования

1. Пример 1.

		Remove-Mailbox -DomainName 'csm.nov.ru' -LName 'test_user';

##### См. также

- [del_user][]

#### New-MailList

Создание группы рассылки, включающей всех пользователей домена. Обёртка
над [create_general_maillist][].

##### Синтаксис

	New-MailList [-DomainName <String>] -MailListLName <String> [-LName <String>] [-Force] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `MailListLName <String>`
        Учётная запись (lname для создаваемой группы рассылки) на Вашем припаркованном домене

        Требуется? true
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `LName <String>`
        Учётная запись (lname для ящиков) на Вашем припаркованном домене, которые должны быть включены в создаваемую групп
        у рассылки

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?false

- `Force [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию False
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `PassThru [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию False
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `<CommonParameters>`
        Этот командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
        [about_CommonParameters][] (http://go.microsoft.com/fwlink/?LinkID=113216).



##### Примеры использования

1. Пример 1.

		New-MailList -DomainName 'csm.nov.ru' -MailListLName 'all';

##### См. также

- [create_general_maillist][]

#### Remove-MailList

Метод предназначен для удаления группы рассылки на "припаркованном" на Яндексе домене.
Обёртка для [delete_general_maillist][].

##### Синтаксис

	Remove-MailList [-DomainName <String>] [-MailListLName] <String> [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `MailListLName <String>`
        Адрес (без домена, lname) удаляемой группы рассылки на Вашем припаркованном домене

        Требуется? true
        Позиция? 1
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByValue)
        Принимать подстановочные знаки?false

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `<CommonParameters>`
        Этот командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
        [about_CommonParameters][] (http://go.microsoft.com/fwlink/?LinkID=113216).



##### Примеры использования

1. Пример 1.

		Remove-MailList -DomainName 'csm.nov.ru' -MailListLName 'test_maillist';

##### См. также

- [delete_general_maillist][]

#### Get-MailListMember

Метод (обёртка над Яндекс.API [get_forward_list][]) предназначен для получения
перенаправлений почты для ящика на "припаркованном" на Яндексе домене.

##### Синтаксис

	Get-MailListMember [-DomainName <String>] [-MailListLName] <String> [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `MailListLName <String>`
        Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене

        Требуется? true
        Позиция? 1
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `<CommonParameters>`
        Этот командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
        [about_CommonParameters][] (http://go.microsoft.com/fwlink/?LinkID=113216).



##### Примеры использования

1. Пример 1.

		Get-MailListMember -DomainName 'csm.nov.ru' -LName 'sergei.s.betke';

##### См. также

- [get_forward_list][]

#### New-MailListMember

Метод (обёртка над Яндекс.API [set_forward][]) предназначен для создания
перенаправлений почты для ящика на "припаркованном" на Яндексе домене.

##### Синтаксис

	New-MailListMember [[-DomainName] <String>] [-MailListLName] <String> [-LName] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса

        Требуется? false
        Позиция? 1
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `MailListLName <String>`
        Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене

        Требуется? true
        Позиция? 2
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `LName <String>`
        Адрес электронной почты (lname) на том же домене для перенаправления почты

        Требуется? true
        Позиция? 3
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?false

- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет

        Требуется? false
        Позиция? named
        Значение по умолчанию False
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `<CommonParameters>`
        Этот командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
        [about_CommonParameters][] (http://go.microsoft.com/fwlink/?LinkID=113216).



##### Примеры использования

1. Пример 1.

		New-MailListMember -DomainName 'csm.nov.ru' -MailListLName 'mail' -LName 'sergei.s.betke';

##### См. также

- [set_forward][]

#### Remove-MailListMember

Метод (обёртка над Яндекс.API [delete_forward][]) предназначен для удаления
перенаправлений почты для ящика на "припаркованном" на Яндексе домене.

##### Синтаксис

	Remove-MailListMember [[-DomainName] <String>] [-MailListLName] <String> [-LName] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса

        Требуется? false
        Позиция? 1
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `MailListLName <String>`
        Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене

        Требуется? true
        Позиция? 2
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `LName <String>`
        Адрес электронной почты (lname) на том же домене для перенаправления почты

        Требуется? true
        Позиция? 3
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?false

- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет

        Требуется? false
        Позиция? named
        Значение по умолчанию False
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?false

- `<CommonParameters>`
        Этот командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
        [about_CommonParameters][] (http://go.microsoft.com/fwlink/?LinkID=113216).



##### Примеры использования

1. Пример 1.

		Remove-MailListMember -DomainName 'csm.nov.ru' -MailListLName 'mail' -LName 'sergei.s.betke';

##### См. также

- [delete_forward][]


[about_CommonParameters]: http://go.microsoft.com/fwlink/?LinkID=113216 "Describes the parameters that can be used with any cmdlet."
[ConvertTo-Contact]: <ITG.Yandex.PDD#ConvertTo-Contact> "Преобразует объект в конвейере в объект со свойствами контакта Яндекс."
[create_general_maillist]: http://api.yandex.ru/pdd/doc/api-pdd/reference/maillist_create_general_maillist.xml 
[del_user]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_del_user.xml 
[delete_forward]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_delete_forward.xml 
[delete_general_maillist]: http://api.yandex.ru/pdd/doc/api-pdd/reference/maillist_delete_general_maillist.xml 
[edit_user]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_edit_user.xml 
[Edit-Mailbox]: <ITG.Yandex.PDD#Edit-Mailbox> "Метод (обёртка над Яндекс.API edit_user) предназначен для редактирования сведений о пользователе ящика на "припаркованном" на Яндексе домене."
[get_domain_users]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-control_get_domain_users.xml 
[get_forward_list]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_get_forward_list.xml 
[Get-Mailbox]: <ITG.Yandex.PDD#Get-Mailbox> "Метод (обёртка над Яндекс.API get_domain_users) Метод позволяет получить список почтовых ящиков."
[Get-MailListMember]: <ITG.Yandex.PDD#Get-MailListMember> "Метод (обёртка над Яндекс.API get_forward_list) предназначен для получения перенаправлений почты для ящика на "припаркованном" на Яндексе домене."
[New-Mailbox]: <ITG.Yandex.PDD#New-Mailbox> "Метод (обёртка над Яндекс.API reg_user) предназначен для регистрации нового пользователя (ящика) на "припаркованном" на Яндексе домене."
[New-MailList]: <ITG.Yandex.PDD#New-MailList> "Создание группы рассылки, включающей всех пользователей домена. Обёртка над create_general_maillist."
[New-MailListMember]: <ITG.Yandex.PDD#New-MailListMember> "Метод (обёртка над Яндекс.API set_forward) предназначен для создания перенаправлений почты для ящика на "припаркованном" на Яндексе домене."
[pdd.yandex.ru]: http://pdd.yandex.ru "Яндекс.Почта для домена"
[reg_default_user]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-control_reg_default_user.xml 
[reg_user]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_reg_user.xml 
[Remove-Mailbox]: <ITG.Yandex.PDD#Remove-Mailbox> "Метод (обёртка над Яндекс.API del_user) предназначен для удаления ящика на "припаркованном" на Яндексе домене."
[Remove-MailList]: <ITG.Yandex.PDD#Remove-MailList> "Метод предназначен для удаления группы рассылки на "припаркованном" на Яндексе домене. Обёртка для delete_general_maillist."
[Remove-MailListMember]: <ITG.Yandex.PDD#Remove-MailListMember> "Метод (обёртка над Яндекс.API delete_forward) предназначен для удаления перенаправлений почты для ящика на "припаркованном" на Яндексе домене."
[set_forward]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_set_forward.xml 
[Set-DefaultEmail]: <ITG.Yandex.PDD#Set-DefaultEmail> "Метод (обёртка над Яндекс.API reg_default_user) предназначен для указания ящика, который будет получать почту при обнаружении в адресе несуществующего на текущий момент в домене lname."

---------------------------------------

Генератор: [ITG.Readme](http://github.com/IT-Service/ITG.Readme "Модуль PowerShell для генерации readme для модулей PowerShell").

