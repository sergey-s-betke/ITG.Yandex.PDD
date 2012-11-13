ITG.Yandex.PDD
==============

Обёртки для API Яндекс.Почта для домена (pdd.yandex.ru) и командлеты на их основе.

Версия модуля: **4.1.0**

Функции модуля
--------------
			
### Admin
			
#### Register-Admin

Метод (обёртка над Яндекс.API set_admin) предназначен для указания логина дополнительного администратора домена.
	
	Register-Admin [-DomainName <String>] [-Credential] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>
			
#### Remove-Admin

Метод (обёртка над Яндекс.API del_admin) предназначен для удаления дополнительного администратора домена.
	
	Remove-Admin [-DomainName <String>] [-Credential] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>
			
### Contact
			
#### ConvertTo-Contact

Преобразует объект в конвейере в объект со свойствами контакта Яндекс.
	
	ConvertTo-Contact [-Фамилия <String>] [-Имя <String>] [-Отчество <String>] [-День Рождения <DateTime>] [-Рабочий телефон <String>] [-Адрес эл. почты <String>] <CommonParameters>
			
### DefaultEmail
			
#### Set-DefaultEmail

Метод (обёртка над Яндекс.API reg_default_user) предназначен для указания ящика, 
который будет получать почту при обнаружении в адресе несуществующего на текущий момент 
в домене lname.
	
	Set-DefaultEmail [-DomainName <String>] [-LName] <String> [-WhatIf] [-Confirm] <CommonParameters>
			
### Domain
			
#### Register-Domain

Метод (обёртка над Яндекс.API reg_domain) предназначен для регистрации домена на сервисах Яндекса.
	
	Register-Domain [-DomainName] <String> [-Token] <String> [-WhatIf] [-Confirm] <CommonParameters>
			
#### Remove-Domain

Метод (обёртка над Яндекс.API del_domain) предназначен для отключения домена от Яндекс.Почта для доменов.
	
	Remove-Domain [-DomainName] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>
			
### Logo
			
#### Remove-Logo

Метод (обёртка над Яндекс.API del_logo) предназначен для удаления логотипа домена.
	
	Remove-Logo [[-DomainName] <String>] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>
			
#### Set-Logo

Метод (обёртка над Яндекс.API add_logo) предназначен для установки логотипа для домена.
	
	Set-Logo [[-DomainName] <String>] [-Path] <FileInfo> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>
			
### Mailbox
			
#### Edit-Mailbox

Метод (обёртка над Яндекс.API edit_user) предназначен для редактирования 
сведений о пользователе ящика на "припаркованном" на Яндексе домене.
	
	Edit-Mailbox [[-DomainName] <String>] [-LName] <String> [-Password] <Object> [[-SecondName] <String>] [[-FirstName] <String>] [[-MiddleName] <String>] [[-Sex] <String>] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>
			
#### Get-Mailbox

Метод (обёртка над Яндекс.API get_domain_users) Метод позволяет получить список почтовых ящиков.
	
	Get-Mailbox [[-DomainName] <String>] [-WhatIf] [-Confirm] <CommonParameters>
			
#### New-Mailbox

Метод (обёртка над Яндекс.API reg_user) предназначен для регистрации 
нового пользователя (ящика) на "припаркованном" на Яндексе домене.
	
	New-Mailbox [-DomainName <String>] -LName <String> -Password <Object> [-SecondName <String>] [-FirstName <String>] [-MiddleName <String>] [-Sex <String>] [-Force] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>
			
#### Remove-Mailbox

Метод (обёртка над Яндекс.API del_user) предназначен для удаления 
ящика на "припаркованном" на Яндексе домене.
	
	Remove-Mailbox [-DomainName <String>] [-LName] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>
			
### MailList
			
#### New-MailList

Создание группы рассылки, включающей всех пользователей домена. Обёртка 
над create_general_maillist.
	
	New-MailList [[-DomainName] <String>] [-MailListLName] <String> [[-LName] <String>] [-Force] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>
			
#### Remove-MailList

Метод предназначен для удаления группы рассылки на "припаркованном" на Яндексе домене. 
Обёртка для delete_general_maillist.
	
	Remove-MailList [-DomainName <String>] [-MailListLName] <String> [-WhatIf] [-Confirm] <CommonParameters>
			
### MailListMember
			
#### Get-MailListMember

Метод (обёртка над Яндекс.API get_forward_list) предназначен для получения 
перенаправлений почты для ящика на "припаркованном" на Яндексе домене.
	
	Get-MailListMember [-DomainName <String>] [-MailListLName] <String> [-WhatIf] [-Confirm] <CommonParameters>
			
#### New-MailListMember

Метод (обёртка над Яндекс.API set_forward) предназначен для создания 
перенаправлений почты для ящика на "припаркованном" на Яндексе домене.
	
	New-MailListMember [[-DomainName] <String>] [-MailListLName] <String> [-LName] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>
			
#### Remove-MailListMember

Метод (обёртка над Яндекс.API delete_forward) предназначен для удаления 
перенаправлений почты для ящика на "припаркованном" на Яндексе домене.
	
	Remove-MailListMember [[-DomainName] <String>] [-MailListLName] <String> [-LName] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

Подробное описание функций модуля
---------------------------------
			
#### Register-Admin


Метод (обёртка над Яндекс.API set_admin) предназначен для указания логина дополнительного администратора домена.
В качестве логина может быть указан только логин на @yandex.ru, но не на домене, делегированном на Яндекс.
Синтаксис запроса
    https://pddimp.yandex.ru/api/multiadmin/add_admin.xml ? token =<токен> & domain =<имя домена> & login =<логин администратора>


##### Синтаксис
	
	Register-Admin [-DomainName <String>] [-Credential] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры	

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?
        
- `Credential <String>`
        Логин дополнительного администратора на @yandex.ru
        
        Требуется?                    true
        Позиция?                    1
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `WhatIf [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `Confirm [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help about_commonparameters".





##### Примеры использования	

1. Пример 1.

		Register-Admin -DomainName 'csm.nov.ru' -Credential 'sergei.e.gushchin';
			
#### Remove-Admin

Метод (обёртка над Яндекс.API del_admin) предназначен для удаления дополнительного администратора домена.
В качестве логина может быть указан только логин на @yandex.ru, но не на домене, делегированном на Яндекс.
Синтаксис запроса
    https://pddimp.yandex.ru/api/multiadmin/del_admin.xml ? token =<токен> & domain =<имя домена> & login =<имя почтового ящика>


##### Синтаксис
	
	Remove-Admin [-DomainName <String>] [-Credential] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры	

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?
        
- `Credential <String>`
        Логин дополнительного администратора на @yandex.ru
        
        Требуется?                    true
        Позиция?                    1
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `WhatIf [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `Confirm [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help about_commonparameters".





##### Примеры использования	

1. Пример 1.

		Remove-Admin -DomainName 'csm.nov.ru' -Credential 'sergei.e.gushchin';
			
#### ConvertTo-Contact

Исходный объект должен обладать реквизитами контакта в соостветствии со схемой AD. 
Выходной объект уже будет обладать реквизитами контакта, ожидаемыми при импорте 
csv файла в ящик на Яндексе.


##### Синтаксис
	
	ConvertTo-Contact [-Фамилия <String>] [-Имя <String>] [-Отчество <String>] [-День Рождения <DateTime>] [-Рабочий телефон <String>] [-Адрес эл. почты <String>] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры	

- `Фамилия <String>`
        Фамилия
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?
        
- `Имя <String>`
        Имя
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?
        
- `Отчество <String>`
        Отчество
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?
        
- `День Рождения <DateTime>`
        дата рождения
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?
        
- `Рабочий телефон <String>`
        телефон рабочий
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?
        
- `Адрес эл. почты <String>`
        адрес электронной почты
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?
        
- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help about_commonparameters".





##### Примеры использования	

1. Пример 1.

		Get-ADUser | ConvertTo-Contact | Export-Csv 'ya.csv';
			
#### Set-DefaultEmail

Метод позволяет задать почтовый ящик по умолчанию для домена. 
Ящик по умолчанию - это ящик, в который приходят все письма на домен, адресованные в 
несуществующие на этом домене ящики. 
Синтаксис запроса:
    https://pddimp.yandex.ru/api/reg_default_user.xml ?
        token =<токен> 
        & domain =<домен> 
        & login =<имя ящика>


##### Синтаксис
	
	Set-DefaultEmail [-DomainName <String>] [-LName] <String> [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры	

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?
        
- `LName <String>`
        имя почтового ящика. Ящик с именем lname должен уже существовать
        
        Требуется?                    true
        Позиция?                    1
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?
        
- `WhatIf [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `Confirm [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help about_commonparameters".





##### Примеры использования	

1. Пример 1.

		Set-DefaultEmail -DomainName 'csm.nov.ru' -LName 'master';

##### Связанные ссылки

- [API Яндекс.Почты - reg_default_user](http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-control_reg_default_user.xml)
			
#### Register-Domain

Метод регистрирует домен на сервисах Яндекса.
Синтаксис запроса
    https://pddimp.yandex.ru/api/reg_domain.xml ? token =<токен> & domain =<имя домена>
Если домен уже подключен, то метод reg_domain не выполняет никаких действий, возвращая секретное
имя и секретную строку.


##### Синтаксис
	
	Register-Domain [-DomainName] <String> [-Token] <String> [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры	

- `DomainName <String>`
        имя домена для регистрации на сервисах Яндекса
        
        Требуется?                    true
        Позиция?                    1
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?
        
- `Token <String>`
        авторизационный токен, полученный через Get-Token. Если не указан, то будет использован
        последний полученный
        
        Требуется?                    true
        Позиция?                    2
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `WhatIf [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `Confirm [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help about_commonparameters".





##### Примеры использования	

1. $token = Get-Token -DomainName 'maindomain.ru';
'domain1.ru', 'domain2.ru' | Register-Domain -Token $token

		Регистрация нескольких доменов:
			
#### Remove-Domain

Метод позволяет отключить домен.
Отключенный домен перестает выводиться в списке доменов. После отключения домен можно подключить заново.
Отключение домена не влечет за собой изменения MX-записей. MX-записи нужно устанавливать отдельно на
DNS-серверах, куда делегирован домен.
Синтаксис запроса
    https://pddimp.yandex.ru/api/del_domain.xml ? token =<токен> & domain =<имя домена>


##### Синтаксис
	
	Remove-Domain [-DomainName] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры	

- `DomainName <String>`
        имя домена для регистрации на сервисах Яндекса
        
        Требуется?                    true
        Позиция?                    1
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?
        
- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `WhatIf [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `Confirm [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help about_commonparameters".





##### Примеры использования	

1. Remove-Domain -DomainName 'test.ru';

		$token = Get-Token -DomainName 'maindomain.ru';
			
#### Remove-Logo

Метод позволяет удалить логотип домена.
Синтаксис запроса
    https://pddimp.yandex.ru/api/del_logo.xml ? token =<токен> & domain =<имя домена>


##### Синтаксис
	
	Remove-Logo [[-DomainName] <String>] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры	

- `DomainName <String>`
        имя домена - любой из доменов, зарегистрированных под Вашей учётной записью на сервисах Яндекса
        если явно домен не указан, то будет использован последний домен, указанный при вызовах yandex.api
        
        Требуется?                    false
        Позиция?                    1
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?
        
- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `WhatIf [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `Confirm [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help about_commonparameters".





##### Примеры использования	

1. Remove-Logo -DomainName 'yourdomain.ru';

		Удаление логотипа для домена yourdomain.ru:

2. $token = Get-Token -DomainName 'maindomain.ru';
'domain1.ru', 'domain2.ru' | Remove-Logo -Token $token

		Удаление логотипа с явным указанием токена для нескольких доменов:
			
#### Set-Logo

Метод позволяет установить логотип домена.
Синтаксис запроса
    https://pddimp.yandex.ru/api/add_logo.xml
Метод вызывается только как POST-запрос. Файл, содержащий логотип, и параметры передаются
как multipart/form-data. Поддерживаются графические файлы форматов jpg, gif, png размером
до 2 Мбайт. Имя файла и название параметра не важны.


##### Синтаксис
	
	Set-Logo [[-DomainName] <String>] [-Path] <FileInfo> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры	

- `DomainName <String>`
        имя домена - любой из доменов, зарегистрированных под Вашей учётной записью на сервисах Яндекса
        если явно домен не указан, то будет использован последний домен, указанный при вызовах yandex.api
        
        Требуется?                    false
        Позиция?                    1
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?
        
- `Path <FileInfo>`
        путь к файлу логотипа.
        Поддерживаются графические файлы форматов jpg, gif, png размером до 2 Мбайт
        
        Требуется?                    true
        Позиция?                    2
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?
        
- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `WhatIf [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `Confirm [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help about_commonparameters".





##### Примеры использования	

1. Set-Logo -DomainName 'yourdomain.ru' -Token $token -Path 'c:\work\logo.png';

		Установка логотипа для домена yourdomain.ru:
			
#### Edit-Mailbox

Метод (обёртка над Яндекс.API edit_user) предназначен для редактирования 
сведений о пользователе ящика на "припаркованном" на Яндексе домене.
Синтаксис запроса:
    https://pddimp.yandex.ru/edit_user.xml ?
        token =<токен>
        & login =<логин пользователя>
        & [password =<пароль пользователя>]
        & [iname =<имя пользователя>]
        & [fname =<фамилия пользователя>]
        & [sex =<пол пользователя>]
        & [hintq =<секретный вопрос>]
        & [hinta =<ответ на секретный вопрос>]


##### Синтаксис
	
	Edit-Mailbox [[-DomainName] <String>] [-LName] <String> [-Password] <Object> [[-SecondName] <String>] [[-FirstName] <String>] [[-MiddleName] <String>] [[-Sex] <String>] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры	

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса
        
        Требуется?                    false
        Позиция?                    1
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?
        
- `LName <String>`
        Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене
        
        Требуется?                    true
        Позиция?                    2
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?
        
- `Password <Object>`
        Пароль к создаваемой учётной записи. Может быть как зашифрованным (SecureString), так и простым текстом
        (String)
        
        Требуется?                    true
        Позиция?                    3
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?
        
- `SecondName <String>`
        Фамилия пользователя
        
        Требуется?                    false
        Позиция?                    4
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?
        
- `FirstName <String>`
        Имя пользователя
        
        Требуется?                    false
        Позиция?                    5
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?
        
- `MiddleName <String>`
        Отчество пользователя
        
        Требуется?                    false
        Позиция?                    6
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?
        
- `Sex <String>`
        Пол пользователя
        
        Требуется?                    false
        Позиция?                    7
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?
        
- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `WhatIf [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `Confirm [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help about_commonparameters".





##### Примеры использования	

1. Пример 1.

		Edit-Mailbox -DomainName 'csm.nov.ru' -LName 'test_user' -Password 'testpassword';

##### Связанные ссылки

- [API Яндекс.Почты - edit_user](http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_edit_user.xml)
			
#### Get-Mailbox

Метод (обёртка над Яндекс.API get_domain_users) Метод позволяет получить список почтовых ящиков. 
Метод возвращает список ящиков в домене, привязанном к токену. 
Синтаксис запроса:
    https://pddimp.yandex.ru/get_domain_users.xml ?
        token =<токен> 
        & on_page =<число записей на странице> 
        & page =<номер страницы>


##### Синтаксис
	
	Get-Mailbox [[-DomainName] <String>] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры	

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса
        
        Требуется?                    false
        Позиция?                    1
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?
        
- `WhatIf [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `Confirm [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help about_commonparameters".





##### Примеры использования	

1. Пример 1.

		Get-Mailbox -DomainName 'csm.nov.ru';

##### Связанные ссылки

- [API Яндекс.Почты - get_domain_users](http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-control_get_domain_users.xml)
			
#### New-Mailbox

Метод (обёртка над Яндекс.API reg_user) предназначен для регистрации 
нового пользователя (ящика) на "припаркованном" на Яндексе домене. 
Синтаксис запроса:
    https://pddimp.yandex.ru/reg_user_token.xml ?
        token =<токен>
        & u_login =<логин пользователя> 
        & u_password =<пароль пользователя>


##### Синтаксис
	
	New-Mailbox [-DomainName <String>] -LName <String> -Password <Object> [-SecondName <String>] [-FirstName <String>] [-MiddleName <String>] [-Sex <String>] [-Force] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры	

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?
        
- `LName <String>`
        Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене
        
        Требуется?                    true
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?
        
- `Password <Object>`
        Пароль к создаваемой учётной записи. Может быть как зашифрованным (SecureString), так и простым текстом
        (String)
        
        Требуется?                    true
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?
        
- `SecondName <String>`
        Фамилия пользователя
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?
        
- `FirstName <String>`
        Имя пользователя
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?
        
- `MiddleName <String>`
        Отчество пользователя
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?
        
- `Sex <String>`
        Пол пользователя
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByPropertyName)
        Принимать подстановочные знаки?
        
- `Force [<SwitchParameter>]`
        перезаписывать ли реквизиты существующих ящиков
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `WhatIf [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `Confirm [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help about_commonparameters".





##### Примеры использования	

1. Пример 1.

		New-Mailbox -DomainName 'csm.nov.ru' -LName 'test_user' -Password 'testpassword';

##### Связанные ссылки

- [API Яндекс.Почты - reg_user](http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_reg_user.xml)
			
#### Remove-Mailbox

Метод (обёртка над Яндекс.API del_user) предназначен для удаления 
ящика на "припаркованном" на Яндексе домене. 
Синтаксис запроса: 
    https://pddimp.yandex.ru/api/del_user.xml ?
        token =<токен>
        & domain =<имя домена> 
        & login =<имя почтового ящика>


##### Синтаксис
	
	Remove-Mailbox [-DomainName <String>] [-LName] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры	

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `LName <String>`
        Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене
        
        Требуется?                    true
        Позиция?                    1
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByValue)
        Принимать подстановочные знаки?
        
- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `WhatIf [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `Confirm [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help about_commonparameters".





##### Примеры использования	

1. Пример 1.

		Remove-Mailbox -DomainName 'csm.nov.ru' -LName 'test_user';

##### Связанные ссылки

- [API Яндекс.Почты - del_user](http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_del_user.xml)
			
#### New-MailList

Создание группы рассылки, включающей всех пользователей домена. Обёртка 
над create_general_maillist.
Синтаксис запроса:
    https://pddimp.yandex.ru/api/create_general_maillist.xml ?
        token =<токен>
        & domain =<имя домена>
        & ml_name =<имя рассылки>


##### Синтаксис
	
	New-MailList [[-DomainName] <String>] [-MailListLName] <String> [[-LName] <String>] [-Force] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры	

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса
        
        Требуется?                    false
        Позиция?                    1
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `MailListLName <String>`
        Учётная запись (lname для создаваемой группы рассылки) на Вашем припаркованном домене
        
        Требуется?                    true
        Позиция?                    2
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `LName <String>`
        Учётная запись (lname для ящиков) на Вашем припаркованном домене, которые должны быть включены в создаваемую групп
        у рассылки
        
        Требуется?                    false
        Позиция?                    3
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?
        
- `Force [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `PassThru [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `WhatIf [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `Confirm [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help about_commonparameters".





##### Примеры использования	

1. Пример 1.

		New-MailList -DomainName 'csm.nov.ru' -MailListLName 'all';

##### Связанные ссылки

- [API Яндекс.Почты - create_general_maillist](http://api.yandex.ru/pdd/doc/api-pdd/reference/maillist_create_general_maillist.xml)
			
#### Remove-MailList

Метод предназначен для удаления группы рассылки на "припаркованном" на Яндексе домене. 
Обёртка для delete_general_maillist. 
Синтаксис запроса:
    https://pddimp.yandex.ru/api/delete_general_maillist.xml ?
        token =<токен>
        & domain =<имя домена>
        & ml_name =<имя рассылки>


##### Синтаксис
	
	Remove-MailList [-DomainName <String>] [-MailListLName] <String> [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры	

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `MailListLName <String>`
        Адрес (без домена, lname) удаляемой группы рассылки на Вашем припаркованном домене
        
        Требуется?                    true
        Позиция?                    1
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByValue)
        Принимать подстановочные знаки?
        
- `WhatIf [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `Confirm [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help about_commonparameters".





##### Примеры использования	

1. Пример 1.

		Remove-MailList -DomainName 'csm.nov.ru' -MailListLName 'test_maillist';

##### Связанные ссылки

- [API Яндекс.Почты - delete_general_maillist](http://api.yandex.ru/pdd/doc/api-pdd/reference/maillist_delete_general_maillist.xml)
			
#### Get-MailListMember

Метод (обёртка над Яндекс.API get_forward_list) предназначен для получения 
перенаправлений почты для ящика на "припаркованном" на Яндексе домене. 
Синтаксис запроса: 
    https://pddimp.yandex.ru/get_forward_list.xml ?
        token =<токен>
        & login =<логин пользователя>


##### Синтаксис
	
	Get-MailListMember [-DomainName <String>] [-MailListLName] <String> [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры	

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `MailListLName <String>`
        Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене
        
        Требуется?                    true
        Позиция?                    1
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `WhatIf [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `Confirm [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help about_commonparameters".





##### Примеры использования	

1. Пример 1.

		Get-MailListMember -DomainName 'csm.nov.ru' -LName 'sergei.s.betke';

##### Связанные ссылки

- [API Яндекс.Почты - get_forward_list](http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_get_forward_list.xml)
			
#### New-MailListMember

Метод (обёртка над Яндекс.API set_forward) предназначен для создания 
перенаправлений почты для ящика на "припаркованном" на Яндексе домене. 
Синтаксис запроса:
    https://pddimp.yandex.ru/set_forward.xml ?
        token =<токен>
        & login =<логин пользователя>
        & address =<e-mail для пересылки>
        & copy =<признак сохранения исходников>


##### Синтаксис
	
	New-MailListMember [[-DomainName] <String>] [-MailListLName] <String> [-LName] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры	

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса
        
        Требуется?                    false
        Позиция?                    1
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `MailListLName <String>`
        Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене
        
        Требуется?                    true
        Позиция?                    2
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `LName <String>`
        Адрес электронной почты (lname) на том же домене для перенаправления почты
        
        Требуется?                    true
        Позиция?                    3
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?
        
- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `WhatIf [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `Confirm [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help about_commonparameters".





##### Примеры использования	

1. Пример 1.

		New-MailListMember -DomainName 'csm.nov.ru' -MailListLName 'mail' -LName 'sergei.s.betke';

##### Связанные ссылки

- [API Яндекс.Почты - set_forward](http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_set_forward.xml)
			
#### Remove-MailListMember

Метод (обёртка над Яндекс.API delete_forward) предназначен для удаления 
перенаправлений почты для ящика на "припаркованном" на Яндексе домене. 
Синтаксис запроса:
    https://pddimp.yandex.ru/delete_forward.xml ?
        token =<токен>
        & login =<логин пользователя>
        & filter_id =<id фильтра>


##### Синтаксис
	
	Remove-MailListMember [[-DomainName] <String>] [-MailListLName] <String> [-LName] <String> [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### Компонент

API Яндекс.Почты для доменов

##### Параметры	

- `DomainName <String>`
        имя домена, зарегистрированного на сервисах Яндекса
        
        Требуется?                    false
        Позиция?                    1
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `MailListLName <String>`
        Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене
        
        Требуется?                    true
        Позиция?                    2
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `LName <String>`
        Адрес электронной почты (lname) на том же домене для перенаправления почты
        
        Требуется?                    true
        Позиция?                    3
        Значение по умолчанию                
        Принимать входные данные конвейера?true (ByValue, ByPropertyName)
        Принимать подстановочные знаки?
        
- `PassThru [<SwitchParameter>]`
        передавать домены далее по конвейеру или нет
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `WhatIf [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `Confirm [<SwitchParameter>]`
        
        Требуется?                    false
        Позиция?                    named
        Значение по умолчанию                
        Принимать входные данные конвейера?false
        Принимать подстановочные знаки?
        
- `<CommonParameters>`
        Данный командлет поддерживает общие параметры: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer и OutVariable. Для получения дополнительных сведений введите
        "get-help about_commonparameters".





##### Примеры использования	

1. Пример 1.

		Remove-MailListMember -DomainName 'csm.nov.ru' -MailListLName 'mail' -LName 'sergei.s.betke';

##### Связанные ссылки

- [API Яндекс.Почты - delete_forward](http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_delete_forward.xml)


