ITG.Yandex.PDD
==============

Обёртки для API Яндекс.Почта для домена pdd.yandex.ru и командлеты на их основе.
[pdd.yandex.ru]: <http://pdd.yandex.ru> "Яндекс.Почта для домена"

Версия модуля: **4.1.1**

Функции модуля
--------------

### Admin

#### Обзор [Get-Admin][]

Метод (обёртка над Яндекс.API [get_admins][]). Метод позволяет получить список
дополнительных администраторов домена.

	Get-Admin [[-DomainName] <String>] [-WhatIf] [-Confirm] <CommonParameters>

Подробнее - [Get-Admin][].

#### Обзор [Register-Admin][]

Метод (обёртка над Яндекс.API [set_admin][]) предназначен для указания логина
дополнительного администратора домена.

	Register-Admin [-DomainName <String>] [-Credential] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

Подробнее - [Register-Admin][].

#### Обзор [Remove-Admin][]

Метод (обёртка над Яндекс.API [del_admin][]) предназначен для удаления
дополнительного администратора домена.

	Remove-Admin [-DomainName <String>] [-Credential] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

Подробнее - [Remove-Admin][].

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

### Domain

#### Обзор [Register-Domain][]

Метод (обёртка над Яндекс.API [reg_domain][]) предназначен для регистрации домена на сервисах Яндекса.

	Register-Domain [-DomainName] <String> [-Token] <String> [-WhatIf] [-Confirm] <CommonParameters>

Подробнее - [Register-Domain][].

#### Обзор [Remove-Domain][]

Метод (обёртка над Яндекс.API [del_domain][]) предназначен для отключения домена от Яндекс.Почта для доменов.

	Remove-Domain [-DomainName] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

Подробнее - [Remove-Domain][].

### Logo

#### Обзор [Remove-Logo][]

Метод (обёртка над Яндекс.API [del_logo][]) предназначен для удаления логотипа домена.

	Remove-Logo [[-DomainName] <String>] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

Подробнее - [Remove-Logo][].

#### Обзор [Set-Logo][]

Метод (обёртка над Яндекс.API [add_logo][]) предназначен для установки логотипа для домена.

	Set-Logo [[-DomainName] <String>] [-Path] <FileInfo> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

Подробнее - [Set-Logo][].

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

#### Get-Admin

Метод (обёртка над Яндекс.API [get_admins][]). Метод позволяет получить список
дополнительных администраторов домена.

##### Синтаксис

	Get-Admin [[-DomainName] <String>] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса

        Требуется? false
        Позиция? 1
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help [about_CommonParameters][]".



##### Примеры использования

1. Пример 1.

		Get-Admin -DomainName 'csm.nov.ru';

##### Связанные ссылки

- [get_admins][]

#### Register-Admin

Метод (обёртка над Яндекс.API [set_admin][]) предназначен для указания логина
дополнительного администратора домена.
В качестве логина может быть указан только логин на @yandex.ru, но не на домене,
делегированном на Яндекс.

##### Синтаксис

	Register-Admin [-DomainName <String>] [-Credential] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?

- `Credential <String>`
        Логин дополнительного администратора на @yandex.ru

        Требуется? true
        Позиция? 1
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help [about_CommonParameters][]".



##### Примеры использования

1. Пример 1.

		Register-Admin -DomainName 'csm.nov.ru' -Credential 'sergei.e.gushchin';

##### Связанные ссылки

- [set_admin][]

#### Remove-Admin

Метод (обёртка над Яндекс.API [del_admin][]) предназначен для удаления
дополнительного администратора домена.
В качестве логина может быть указан только логин на @yandex.ru, но
не на домене, делегированном на Яндекс.

##### Синтаксис

	Remove-Admin [-DomainName <String>] [-Credential] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?

- `Credential <String>`
        Логин дополнительного администратора на @yandex.ru

        Требуется? true
        Позиция? 1
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help [about_CommonParameters][]".



##### Примеры использования

1. Пример 1.

		Remove-Admin -DomainName 'csm.nov.ru' -Credential 'sergei.e.gushchin';

##### Связанные ссылки

- [del_admin][]

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
        Принимать подстановочные знаки?

- `Имя <String>`
        Имя

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?

- `Отчество <String>`
        Отчество

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?

- `День Рождения <DateTime>`
        дата рождения

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?

- `Рабочий телефон <String>`
        телефон рабочий

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?

- `Адрес эл. почты <String>`
        адрес электронной почты

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?

- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help [about_CommonParameters][]".



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
        Принимать подстановочные знаки?

- `LName <String>`
        имя почтового ящика. Ящик с именем `$LName` должен уже существовать

        Требуется? true
        Позиция? 1
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help [about_CommonParameters][]".



##### Примеры использования

1. Пример 1.

		Set-DefaultEmail -DomainName 'csm.nov.ru' -LName 'master';

##### Связанные ссылки

- [reg_default_user][]

#### Register-Domain

Метод регистрирует домен на сервисах Яндекса.
Если домен уже подключен, то метод [reg_domain][] не выполняет никаких действий.

##### Синтаксис

	Register-Domain [-DomainName] <String> [-Token] <String> [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры

- `DomainName <String>`
        имя домена для регистрации на сервисах Яндекса

        Требуется? true
        Позиция? 1
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?

- `Token <String>`
        авторизационный токен, полученный через [Get-Token][], для другого, уже зарегистрированного домена

        Требуется? true
        Позиция? 2
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help [about_CommonParameters][]".



##### Примеры использования

1. Регистрация нескольких доменов

		$token = Get-Token -DomainName 'maindomain.ru';	'domain1.ru', 'domain2.ru' | Register-Domain -Token $token;

##### Связанные ссылки

- [reg_domain][]

#### Remove-Domain

Метод позволяет отключить домен.
Отключенный домен перестает выводиться в списке доменов. После отключения домен можно подключить заново.
Отключение домена не влечет за собой изменения MX-записей. MX-записи нужно устанавливать отдельно на
DNS-серверах, куда делегирован домен.

##### Синтаксис

	Remove-Domain [-DomainName] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры

- `DomainName <String>`
        имя домена для регистрации на сервисах Яндекса

        Требуется? true
        Позиция? 1
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?

- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help [about_CommonParameters][]".



##### Примеры использования

1. Пример 1.

		Remove-Domain -DomainName 'test.ru';

##### Связанные ссылки

- [del_domain][]

#### Remove-Logo

Метод позволяет удалить логотип домена.

##### Синтаксис

	Remove-Logo [[-DomainName] <String>] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры

- `DomainName <String>`
        имя домена - любой из доменов, зарегистрированных под Вашей учётной записью на сервисах Яндекса

        Требуется? false
        Позиция? 1
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?

- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help [about_CommonParameters][]".



##### Примеры использования

1. Удаление логотипа для домена yourdomain.ru.

		Remove-Logo -DomainName 'yourdomain.ru';

2. Удаление логотипа для нескольких доменов.

		'domain1.ru', 'domain2.ru' | Remove-Logo;

##### Связанные ссылки

- [del_logo][]

#### Set-Logo

Метод позволяет установить логотип домена.
Поддерживаются графические файлы форматов jpg, gif, png размером
до 2 Мбайт.

##### Синтаксис

	Set-Logo [[-DomainName] <String>] [-Path] <FileInfo> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры

- `DomainName <String>`
        имя домена - любой из доменов, зарегистрированных под Вашей учётной записью на сервисах Яндекса

        Требуется? false
        Позиция? 1
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?

- `Path <FileInfo>`
        путь к файлу логотипа.
        Поддерживаются графические файлы форматов jpg, gif, png размером до 2 Мбайт

        Требуется? true
        Позиция? 2
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?

- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help [about_CommonParameters][]".



##### Примеры использования

1. Установка логотипа для домена yourdomain.ru

		Set-Logo -DomainName 'yourdomain.ru' -Path 'c:\work\logo.png';

##### Связанные ссылки

- [add_logo][]

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
        Принимать подстановочные знаки?

- `LName <String>`
        Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене

        Требуется? true
        Позиция? 2
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?

- `Password <Object>`
        Пароль к создаваемой учётной записи. Может быть как зашифрованным (SecureString), так и простым текстом
        (String)

        Требуется? true
        Позиция? 3
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?

- `SecondName <String>`
        Фамилия пользователя

        Требуется? false
        Позиция? 4
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?

- `FirstName <String>`
        Имя пользователя

        Требуется? false
        Позиция? 5
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?

- `MiddleName <String>`
        Отчество пользователя

        Требуется? false
        Позиция? 6
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?

- `Sex <String>`
        Пол пользователя

        Требуется? false
        Позиция? 7
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?

- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help [about_CommonParameters][]".



##### Примеры использования

1. Пример 1.

		Edit-Mailbox -DomainName 'csm.nov.ru' -LName 'test_user' -Password 'testpassword';

##### Связанные ссылки

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
        Принимать подстановочные знаки?

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help [about_CommonParameters][]".



##### Примеры использования

1. Пример 1.

		Get-Mailbox -DomainName 'csm.nov.ru';

##### Связанные ссылки

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
        Принимать подстановочные знаки?

- `LName <String>`
        Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене

        Требуется? true
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?

- `Password <Object>`
        Пароль к создаваемой учётной записи. Может быть как зашифрованным (SecureString), так и простым текстом
        (String)

        Требуется? true
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?

- `SecondName <String>`
        Фамилия пользователя

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?

- `FirstName <String>`
        Имя пользователя

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?

- `MiddleName <String>`
        Отчество пользователя

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?

- `Sex <String>`
        Пол пользователя

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?

- `Force [<SwitchParameter>]`
        перезаписывать ли реквизиты существующих ящиков

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help [about_CommonParameters][]".



##### Примеры использования

1. Пример 1.

		New-Mailbox -DomainName 'csm.nov.ru' -LName 'test_user' -Password 'testpassword';

##### Связанные ссылки

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
        Принимать подстановочные знаки?

- `LName <String>`
        Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене

        Требуется? true
        Позиция? 1
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByValue)
        Принимать подстановочные знаки?

- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help [about_CommonParameters][]".



##### Примеры использования

1. Пример 1.

		Remove-Mailbox -DomainName 'csm.nov.ru' -LName 'test_user';

##### Связанные ссылки

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
        Принимать подстановочные знаки?

- `MailListLName <String>`
        Учётная запись (lname для создаваемой группы рассылки) на Вашем припаркованном домене

        Требуется? true
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `LName <String>`
        Учётная запись (lname для ящиков) на Вашем припаркованном домене, которые должны быть включены в создаваемую групп
        у рассылки

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?

- `Force [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `PassThru [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help [about_CommonParameters][]".



##### Примеры использования

1. Пример 1.

		New-MailList -DomainName 'csm.nov.ru' -MailListLName 'all';

##### Связанные ссылки

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
        Принимать подстановочные знаки?

- `MailListLName <String>`
        Адрес (без домена, lname) удаляемой группы рассылки на Вашем припаркованном домене

        Требуется? true
        Позиция? 1
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByValue)
        Принимать подстановочные знаки?

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help [about_CommonParameters][]".



##### Примеры использования

1. Пример 1.

		Remove-MailList -DomainName 'csm.nov.ru' -MailListLName 'test_maillist';

##### Связанные ссылки

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
        Принимать подстановочные знаки?

- `MailListLName <String>`
        Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене

        Требуется? true
        Позиция? 1
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help [about_CommonParameters][]".



##### Примеры использования

1. Пример 1.

		Get-MailListMember -DomainName 'csm.nov.ru' -LName 'sergei.s.betke';

##### Связанные ссылки

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
        Принимать подстановочные знаки?

- `MailListLName <String>`
        Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене

        Требуется? true
        Позиция? 2
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `LName <String>`
        Адрес электронной почты (lname) на том же домене для перенаправления почты

        Требуется? true
        Позиция? 3
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?

- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help [about_CommonParameters][]".



##### Примеры использования

1. Пример 1.

		New-MailListMember -DomainName 'csm.nov.ru' -MailListLName 'mail' -LName 'sergei.s.betke';

##### Связанные ссылки

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
        Принимать подстановочные знаки?

- `MailListLName <String>`
        Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене

        Требуется? true
        Позиция? 2
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `LName <String>`
        Адрес электронной почты (lname) на том же домене для перенаправления почты

        Требуется? true
        Позиция? 3
        Значение по умолчанию
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?

- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `WhatIf [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `Confirm [<SwitchParameter>]`

        Требуется? false
        Позиция? named
        Значение по умолчанию
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?

- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help [about_CommonParameters][]".



##### Примеры использования

1. Пример 1.

		Remove-MailListMember -DomainName 'csm.nov.ru' -MailListLName 'mail' -LName 'sergei.s.betke';

##### Связанные ссылки

- [delete_forward][]


[about_CommonParameters]: http://go.microsoft.com/fwlink/?LinkID=113216 "Описание параметров, которые могут использоваться с любым командлетом."
[add_logo]:  
[ConvertTo-Contact]: <ITG.Yandex.PDD#ConvertTo-Contact> "Преобразует объект в конвейере в объект со свойствами контакта Яндекс."
[create_general_maillist]: http://api.yandex.ru/pdd/doc/api-pdd/reference/maillist_create_general_maillist.xml 
[del_admin]:  
[del_domain]:  
[del_logo]:  
[del_user]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_del_user.xml 
[delete_forward]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_delete_forward.xml 
[delete_general_maillist]: http://api.yandex.ru/pdd/doc/api-pdd/reference/maillist_delete_general_maillist.xml 
[edit_user]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_edit_user.xml 
[Edit-Mailbox]: <ITG.Yandex.PDD#Edit-Mailbox> "Метод (обёртка над Яндекс.API edit_user) предназначен для редактирования сведений о пользователе ящика на "припаркованном" на Яндексе домене."
[get_admins]:  
[get_domain_users]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-control_get_domain_users.xml 
[get_forward_list]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_get_forward_list.xml 
[Get-Admin]: <#Get-Admin> "Метод (обёртка над Яндекс.API get_admins). Метод позволяет получить список дополнительных администраторов домена."
[Get-Mailbox]: <ITG.Yandex.PDD#Get-Mailbox> "Метод (обёртка над Яндекс.API get_domain_users) Метод позволяет получить список почтовых ящиков."
[Get-MailListMember]: <ITG.Yandex.PDD#Get-MailListMember> "Метод (обёртка над Яндекс.API get_forward_list) предназначен для получения перенаправлений почты для ящика на "припаркованном" на Яндексе домене."
[Get-Token]: <ITG.Yandex#Get-Token> "Метод (обёртка над Яндекс.API get_token) предназначен для получения авторизационного токена."
[New-Mailbox]: <ITG.Yandex.PDD#New-Mailbox> "Метод (обёртка над Яндекс.API reg_user) предназначен для регистрации нового пользователя (ящика) на "припаркованном" на Яндексе домене."
[New-MailList]: <ITG.Yandex.PDD#New-MailList> "Создание группы рассылки, включающей всех пользователей домена. Обёртка над create_general_maillist."
[New-MailListMember]: <ITG.Yandex.PDD#New-MailListMember> "Метод (обёртка над Яндекс.API set_forward) предназначен для создания перенаправлений почты для ящика на "припаркованном" на Яндексе домене."
[reg_default_user]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-control_reg_default_user.xml 
[reg_domain]:  
[reg_user]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_reg_user.xml 
[Register-Admin]: <#Register-Admin> "Метод (обёртка над Яндекс.API set_admin) предназначен для указания логина дополнительного администратора домена."
[Register-Domain]: <#Register-Domain> "Метод (обёртка над Яндекс.API reg_domain) предназначен для регистрации домена на сервисах Яндекса."
[Remove-Admin]: <#Remove-Admin> "Метод (обёртка над Яндекс.API del_admin) предназначен для удаления дополнительного администратора домена."
[Remove-Domain]: <#Remove-Domain> "Метод (обёртка над Яндекс.API del_domain) предназначен для отключения домена от Яндекс.Почта для доменов."
[Remove-Logo]: <#Remove-Logo> "Метод (обёртка над Яндекс.API del_logo) предназначен для удаления логотипа домена."
[Remove-Mailbox]: <ITG.Yandex.PDD#Remove-Mailbox> "Метод (обёртка над Яндекс.API del_user) предназначен для удаления ящика на "припаркованном" на Яндексе домене."
[Remove-MailList]: <ITG.Yandex.PDD#Remove-MailList> "Метод предназначен для удаления группы рассылки на "припаркованном" на Яндексе домене. Обёртка для delete_general_maillist."
[Remove-MailListMember]: <ITG.Yandex.PDD#Remove-MailListMember> "Метод (обёртка над Яндекс.API delete_forward) предназначен для удаления перенаправлений почты для ящика на "припаркованном" на Яндексе домене."
[set_admin]:  
[set_forward]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_set_forward.xml 
[Set-DefaultEmail]: <ITG.Yandex.PDD#Set-DefaultEmail> "Метод (обёртка над Яндекс.API reg_default_user) предназначен для указания ящика, который будет получать почту при обнаружении в адресе несуществующего на текущий момент в домене lname."
[Set-Logo]: <#Set-Logo> "Метод (обёртка над Яндекс.API add_logo) предназначен для установки логотипа для домена."

---------------------------------------

Генератор: [ITG.Readme](http://github.com/IT-Service/ITG.Readme "Модуль PowerShell для генерации readme для модулей PowerShell").

