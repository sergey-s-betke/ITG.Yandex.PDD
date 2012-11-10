'ITG.Yandex' `
, 'ITG.RegExps' `
, 'ITG.Utils' `
| Import-Module;

function Register-Domain {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
			Метод (обёртка над Яндекс.API reg_domain) предназначен для регистрации домена на сервисах Яндекса.
		.Description
			Метод регистрирует домен на сервисах Яндекса.
			Синтаксис запроса
				https://pddimp.yandex.ru/api/reg_domain.xml ? token =<токен> & domain =<имя домена>
			Если домен уже подключен, то метод reg_domain не выполняет никаких действий, возвращая секретное
			имя и секретную строку.
		.Link
			http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-control_reg_domain.xml
		.Example
			Регистрация нескольких доменов:
			$token = Get-Token -DomainName 'maindomain.ru';
			'domain1.ru', 'domain2.ru' | Register-Domain -Token $token
	#>

	[CmdletBinding(
		SupportsShouldProcess=$true,
		ConfirmImpact="Medium"
	)]
	
	param (
		# имя домена для регистрации на сервисах Яндекса
		[Parameter(
			Mandatory=$true,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true
		)]
		[string]
		[ValidateScript( { $_ -match "^$($reDomain)$" } )]
		[Alias("domain_name")]
		[Alias("Domain")]
		$DomainName
	,
		# авторизационный токен, полученный через Get-Token. Если не указан, то будет использован
		# последний полученный
		[Parameter(
			Mandatory=$true
		)]
		[string]
		[ValidateNotNullOrEmpty()]
		$Token
	)

	process {
		Invoke-API `
			-method 'api/reg_domain' `
			-Token $Token `
			-DomainName $DomainName `
			-SuccessMsg "Домен $($DomainName) успешно подключен." `
			-ResultFilter { 
				$_.action.domains.domain `
				| Select-Object -Property `
					@{Name='DomainName'; Expression={$_.name}}`
					, @{Name='SecretName'; Expression={$_.secret_name.'#text'}} `
					, @{Name='SecretValue'; Expression={$_.secret_value.'#text'}} `
			} `
		;
	}
}

function Remove-Domain {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
			Метод (обёртка над Яндекс.API del_domain) предназначен для отключения домена от Яндекс.Почта для доменов.
		.Description
			Метод позволяет отключить домен.
			Отключенный домен перестает выводиться в списке доменов. После отключения домен можно подключить заново.
			Отключение домена не влечет за собой изменения MX-записей. MX-записи нужно устанавливать отдельно на
			DNS-серверах, куда делегирован домен.
			Синтаксис запроса
				https://pddimp.yandex.ru/api/del_domain.xml ? token =<токен> & domain =<имя домена>
		.Link
			http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-control_del_domain.xml
		.Example
			$token = Get-Token -DomainName 'maindomain.ru';
			Remove-Domain -DomainName 'test.ru';
	#>

	[CmdletBinding(
		SupportsShouldProcess=$true,
		ConfirmImpact="High"
	)]
	
	param (
		# имя домена для регистрации на сервисах Яндекса
		[Parameter(
			Mandatory=$true,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true
		)]
		[string]
		[ValidateScript( { $_ -match "^$($reDomain)$" } )]
		[Alias("domain_name")]
		[Alias("Domain")]
		$DomainName
	,
		# передавать домены далее по конвейеру или нет
		[switch]
		$PassThru
	)

	process {
		Invoke-API `
			-method 'api/del_domain' `
			-DomainName $DomainName `
			-SuccessMsg "Домен $($DomainName) успешно отключен." `
		;
		if ( $PassThru ) { $input };
	}
}

function Set-DefaultEmail {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
			Метод (обёртка над Яндекс.API reg_default_user) предназначен для указания ящика,
			который будет получать почту при обнаружении в адресе несуществующего на текущий момент
			в домене lname.
		.Description
			Метод позволяет задать почтовый ящик по умолчанию для домена.
			Ящик по умолчанию - это ящик, в который приходят все письма на домен, адресованные в
			несуществующие на этом домене ящики.
			Синтаксис запроса
				https://pddimp.yandex.ru/api/reg_default_user.xml ? token =<токен> & domain =<домен> & login =<имя ящика>
		.Link
			http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-control_reg_default_user.xml
		.Example
			Set-DefaultEmail -DomainName 'csm.nov.ru' -LName 'master';
	#>

	[CmdletBinding(
		SupportsShouldProcess=$true,
		ConfirmImpact="Medium"
	)]
	
	param (
		# имя домена, зарегистрированного на сервисах Яндекса
		[Parameter(
			Mandatory=$false,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true
		)]
		[string]
		[ValidateScript( { $_ -match "^$($reDomain)$" } )]
		[Alias("domain_name")]
		[Alias("Domain")]
		$DomainName
	,
		# имя почтового ящика. Ящик с именем lname должен уже существовать
		[Parameter(
			Mandatory=$true
			, ValueFromPipelineByPropertyName=$true
			, Position=0
			, ValueFromRemainingArguments=$true
		)]
		[string]
		[ValidateNotNullOrEmpty()]
		[Alias("DefaultEmail")]
		[Alias("default_email")]
		[Alias("login")]
		$LName
	)

	process {
		Invoke-API `
			-method 'api/reg_default_user' `
			-DomainName $DomainName `
			-Params @{
				login = $LName
			} `
			-IsSuccessPredicate { [bool]$_.action.status.'action-status'.get_item('success') } `
			-IsFailurePredicate { [bool]$_.action.status.'action-status'.get_item('error') } `
			-FailureMsgFilter { $_.action.status.'action-status'.error.'#text' } `
		;
	}
}

function Set-Logo {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
			Метод (обёртка над Яндекс.API add_logo) предназначен для установки логотипа для домена.
		.Description
			Метод позволяет установить логотип домена.
			Синтаксис запроса
				https://pddimp.yandex.ru/api/add_logo.xml
			Метод вызывается только как POST-запрос. Файл, содержащий логотип, и параметры передаются
			как multipart/form-data. Поддерживаются графические файлы форматов jpg, gif, png размером
			до 2 Мбайт. Имя файла и название параметра не важны.
		.Link
			http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-control_add_logo.xml
		.Example
			Установка логотипа для домена yourdomain.ru:
			Set-Logo -DomainName 'yourdomain.ru' -Token $token -Path 'c:\work\logo.png';
	#>

	[CmdletBinding(
		SupportsShouldProcess=$true,
		ConfirmImpact="Low"
	)]
	
	param (
		# имя домена - любой из доменов, зарегистрированных под Вашей учётной записью на сервисах Яндекса
		# если явно домен не указан, то будет использован последний домен, указанный при вызовах yandex.api
		[Parameter(
			Mandatory=$false,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true
		)]
		[string]
		[ValidateScript( { $_ -match "^$($reDomain)$" } )]
		[Alias("domain_name")]
		[Alias("Domain")]
		$DomainName
	,
		# путь к файлу логотипа.
		# Поддерживаются графические файлы форматов jpg, gif, png размером до 2 Мбайт
		[Parameter(
			Mandatory=$true,
			ValueFromPipelineByPropertyName=$true
		)]
		[System.IO.FileInfo]
		$Path
	,
		# передавать домены далее по конвейеру или нет
		[switch]
		$PassThru
	)

	process {
		Invoke-API `
			-HttpMethod 'POST' `
			-method 'api/add_logo' `
			-DomainName $DomainName `
			-Params @{
				file = $Path
			} `
			-IsSuccessPredicate { [bool]$_.action.domains.domain.logo.'action-status'.get_item('success') } `
			-SuccessMsg "Логотип для домена $($DomainName) установлен." `
			-IsFailurePredicate { [bool]$_.action.domains.domain.logo.'action-status'.get_item('error') } `
			-FailureMsgFilter { $_.action.domains.domain.logo.'action-status'.error } `
		;
		if ( $PassThru ) { $input };
	}
}

function Remove-Logo {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
			Метод (обёртка над Яндекс.API del_logo) предназначен для удаления логотипа домена.
		.Description
			Метод позволяет удалить логотип домена.
			Синтаксис запроса
				https://pddimp.yandex.ru/api/del_logo.xml ? token =<токен> & domain =<имя домена>
		.Link
			http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-control_del_logo.xml#domain-control_del_logo
		.Example
			Удаление логотипа для домена yourdomain.ru:
			Remove-Logo -DomainName 'yourdomain.ru';
		.Example
			Удаление логотипа с явным указанием токена для нескольких доменов:
			$token = Get-Token -DomainName 'maindomain.ru';
			'domain1.ru', 'domain2.ru' | Remove-Logo -Token $token
	#>

	[CmdletBinding(
		SupportsShouldProcess=$true,
		ConfirmImpact="Low"
	)]
	
	param (
		# имя домена - любой из доменов, зарегистрированных под Вашей учётной записью на сервисах Яндекса
		# если явно домен не указан, то будет использован последний домен, указанный при вызовах yandex.api
		[Parameter(
			Mandatory=$false,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true
		)]
		[string]
		[ValidateScript( { $_ -match "^$($reDomain)$" } )]
		[Alias("domain_name")]
		[Alias("Domain")]
		$DomainName
	,
		# передавать домены далее по конвейеру или нет
		[switch]
		$PassThru
	)

	process {
		Invoke-API `
			-method 'api/del_logo' `
			-DomainName $DomainName `
			-SuccessMsg "Логотип для домена $($DomainName) удалён." `
		;
		if ( $PassThru ) { $input };
	}
}

function Get-Mailboxes {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
			Метод (обёртка над Яндекс.API get_domain_users) Метод позволяет получить список почтовых ящиков.
		.Description
			Метод (обёртка над Яндекс.API get_domain_users) Метод позволяет получить список почтовых ящиков.
			Метод возвращает список ящиков в домене, привязанном к токену.
			Синтаксис запроса
				https://pddimp.yandex.ru/get_domain_users.xml ? token =<токен> & on_page =<число записей на странице> & page =<номер страницы>
		.Link
			http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-control_get_domain_users.xml
		.Example
			Get-Mailboxes -DomainName 'csm.nov.ru';
	#>

	[CmdletBinding(
		SupportsShouldProcess=$true,
		ConfirmImpact="Low"
	)]
	
	param (
		# имя домена, зарегистрированного на сервисах Яндекса
		[Parameter(
			Mandatory=$false,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true
		)]
		[string]
		[ValidateScript( { $_ -match "^$($reDomain)$" } )]
		[Alias("domain_name")]
		[Alias("Domain")]
		$DomainName
	)

	process {
		Invoke-API `
			-method 'get_domain_users' `
			-DomainName $DomainName `
			-Params @{
				on_page = 1000; 
				page = 1
			} `
			-IsSuccessPredicate { [bool]$_.SelectSingleNode('page/domains/domain/emails/action-status') } `
			-IsFailurePredicate { [bool]$_.page.error } `
			-FailureMsgFilter { $_.page.error.reason } `
			-ResultFilter { 
				$_.page.domains.domain.emails.email `
				| %{ $_.name; } `
			} `
		;
	}
}

function Get-Admins {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
			Метод (обёртка над Яндекс.API get_admins). Метод позволяет получить список дополнительных администраторов домена.
		.Description
			Метод (обёртка над Яндекс.API get_admins). Метод позволяет получить список дополнительных администраторов домена.
			Метод возвращает список дополнительных администраторов для домена, привязанного к токену.
			Синтаксис запроса
				https://pddimp.yandex.ru/api/multiadmin/get_admins.xml ? token =<токен> & domain =<имя домена>
		.Link
			http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-control_get_admins.xml
		.Example
			Get-Admins -DomainName 'csm.nov.ru';
	#>

	[CmdletBinding(
		SupportsShouldProcess=$true,
		ConfirmImpact="Low"
	)]
	
	param (
		# имя домена, зарегистрированного на сервисах Яндекса
		[Parameter(
			Mandatory=$false,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true
		)]
		[string]
		[ValidateScript( { $_ -match "^$($reDomain)$" } )]
		[Alias("domain_name")]
		[Alias("Domain")]
		$DomainName
	)

	process {
		Invoke-API `
			-method 'api/multiadmin/get_admins' `
			-DomainName $DomainName `
			-IsSuccessPredicate { [bool]$_.SelectSingleNode('action/domain/status/success') } `
			-IsFailurePredicate { [bool]$_.SelectSingleNode('action/domain/status/error') } `
			-FailureMsgFilter { $_.action.domain.status.error } `
			-ResultFilter { 
				$_.SelectNodes('action/domain/other-admins/login') `
				| %{ $_.'#text'; } `
			} `
		;
	}
}

function Register-Admin {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
			Метод (обёртка над Яндекс.API set_admin) предназначен для указания логина дополнительного администратора домена.
		.Description
			Метод (обёртка над Яндекс.API set_admin) предназначен для указания логина дополнительного администратора домена.
			В качестве логина может быть указан только логин на @yandex.ru, но не на домене, делегированном на Яндекс.
			Синтаксис запроса
				https://pddimp.yandex.ru/api/multiadmin/add_admin.xml ? token =<токен> & domain =<имя домена> & login =<логин администратора>
		.Link
			http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-control_add_admin.xml
		.Example
			Register-Admin -DomainName 'csm.nov.ru' -Credential 'sergei.e.gushchin';
	#>

	[CmdletBinding(
		SupportsShouldProcess=$true,
		ConfirmImpact="High"
	)]
	
	param (
		# имя домена, зарегистрированного на сервисах Яндекса
		[Parameter(
			Mandatory=$false
			, ValueFromPipeline=$true
			, ValueFromPipelineByPropertyName=$true
		)]
		[string]
		[ValidateScript( { $_ -match "^$($reDomain)$" } )]
		[Alias("domain_name")]
		[Alias("Domain")]
		$DomainName
	,
		# Логин дополнительного администратора на @yandex.ru
		[Parameter(
			Mandatory=$true
			, Position=0
			, ValueFromRemainingArguments=$true
		)]
		[string]
		[ValidateNotNullOrEmpty()]
		[Alias("Admin")]
		[Alias("Name")]
		[Alias("Login")]
		$Credential
	,
		# передавать домены далее по конвейеру или нет
		[switch]
		$PassThru
	)

	process {
		Invoke-API `
			-method 'api/multiadmin/add_admin' `
			-DomainName $DomainName `
			-Params @{
				login = $Credential
			} `
			-IsSuccessPredicate { [bool]$_.SelectSingleNode('action/domain/status/success') } `
			-IsFailurePredicate { [bool]$_.SelectSingleNode('action/domain/status/error') } `
			-FailureMsgFilter { $_.action.domain.status.error } `
		;
		if ( $PassThru ) { $input };
	}
}

function Remove-Admin {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
			Метод (обёртка над Яндекс.API del_admin) предназначен для удаления дополнительного администратора домена.
		.Description
			Метод (обёртка над Яндекс.API del_admin) предназначен для удаления дополнительного администратора домена.
			В качестве логина может быть указан только логин на @yandex.ru, но не на домене, делегированном на Яндекс.
			Синтаксис запроса
				https://pddimp.yandex.ru/api/multiadmin/del_admin.xml ? token =<токен> & domain =<имя домена> & login =<имя почтового ящика>
		.Link
			http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-control_del_admin.xml
		.Example
			Remove-Admin -DomainName 'csm.nov.ru' -Credential 'sergei.e.gushchin';
	#>

	[CmdletBinding(
		SupportsShouldProcess=$true,
		ConfirmImpact="High"
	)]
	
	param (
		# имя домена, зарегистрированного на сервисах Яндекса
		[Parameter(
			Mandatory=$false
			, ValueFromPipeline=$true
			, ValueFromPipelineByPropertyName=$true
		)]
		[string]
		[ValidateScript( { $_ -match "^$($reDomain)$" } )]
		[Alias("domain_name")]
		[Alias("Domain")]
		$DomainName
	,
		# Логин дополнительного администратора на @yandex.ru
		[Parameter(
			Mandatory=$true
			, Position=0
			, ValueFromRemainingArguments=$true
		)]
		[string]
		[ValidateNotNullOrEmpty()]
		[Alias("Admin")]
		[Alias("Name")]
		[Alias("Login")]
		$Credential
	,
		# передавать домены далее по конвейеру или нет
		[switch]
		$PassThru
	)

	process {
		Invoke-API `
			-method 'api/multiadmin/del_admin' `
			-DomainName $DomainName `
			-Params @{
				login = $Credential
			} `
			-IsSuccessPredicate { [bool]$_.SelectSingleNode('action/domain/status/success') } `
			-IsFailurePredicate { [bool]$_.SelectSingleNode('action/domain/status/error') } `
			-FailureMsgFilter { $_.action.domain.status.error } `
		;
		if ( $PassThru ) { $input };
	}
}

function New-Mailbox {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
			Метод (обёртка над Яндекс.API reg_user) предназначен для регистрации
			нового пользователя (ящика) на "припаркованном" на Яндексе домене.
		.Description
			Метод (обёртка над Яндекс.API reg_user) предназначен для регистрации
			нового пользователя (ящика) на "припаркованном" на Яндексе домене.
			Синтаксис запроса
				https://pddimp.yandex.ru/reg_user_token.xml ? token =<токен>
				& u_login =<логин пользователя> & u_password =<пароль пользователя>
		.Link
			http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_reg_user.xml
		.Example
			New-Mailbox -DomainName 'csm.nov.ru' -LName 'test_user' -Password 'testpassword';
	#>

	[CmdletBinding(
		SupportsShouldProcess=$true
		, ConfirmImpact="High"
	)]
	
	param (
		# имя домена, зарегистрированного на сервисах Яндекса
		[Parameter(
			Mandatory=$false
			, ValueFromPipelineByPropertyName=$true
		)]
		[string]
		[ValidateScript( { $_ -match "^$($reDomain)$" } )]
		[Alias("domain_name")]
		[Alias("Domain")]
		$DomainName
	,
		# Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене
		[Parameter(
			Mandatory=$true
			, ValueFromPipelineByPropertyName=$true
		)]
		[System.String]
		[ValidateNotNullOrEmpty()]
		[Alias("Email")]
		[Alias("Login")]
		[Alias("mailNickname")]
		$LName
	,
		# Пароль к создаваемой учётной записи. Может быть как зашифрованным (SecureString), так и простым текстом
		#(String)
		[Parameter(
			Mandatory=$true
			, ValueFromPipelineByPropertyName=$true
		)]
		[ValidateScript({
			[System.String] `
			, [System.Security.SecureString] `
			-contains ( $_.GetType() )
		})]
		[ValidateNotNullOrEmpty()]
		$Password
	,
		# Фамилия пользователя
		[Parameter(
			Mandatory=$false
			, ValueFromPipelineByPropertyName=$true
			, ParameterSetName="ExtraAccountAttributes"
		)]
		[System.String]
		[ValidateNotNullOrEmpty()]
		[Alias("sn")]
		$SecondName
	,
		# Имя пользователя
		[Parameter(
			Mandatory=$false
			, ValueFromPipelineByPropertyName=$true
			, ParameterSetName="ExtraAccountAttributes"
		)]
		[System.String]
		[ValidateNotNullOrEmpty()]
		[Alias("givenName")]
		$FirstName
	,
		# Отчество пользователя
		[Parameter(
			Mandatory=$false
			, ValueFromPipelineByPropertyName=$true
			, ParameterSetName="ExtraAccountAttributes"
		)]
		[System.String]
		[ValidateNotNull()]
		$MiddleName
	,
		# Пол пользователя
		[Parameter(
			Mandatory=$false
			, ValueFromPipelineByPropertyName=$true
			, ParameterSetName="ExtraAccountAttributes"
		)]
		[System.String]
		[ValidateSet("м", "ж")]
		$Sex
	,
		# перезаписывать ли реквизиты существующих ящиков
		[switch]
		$Force
	,
		# передавать домены далее по конвейеру или нет
		[switch]
		$PassThru
	)

	begin {
		$Mailboxes = @( Get-Mailboxes -DomainName $DomainName );
	}
	process {
		if ( $Password -is [System.Security.SecureString] ) {
			$Credential = New-Object System.Management.Automation.PSCredential( 
				$LName, 
				$Password
			);
			$Password = $Credential.GetNetworkCredential().Password;
		};
		$SexDig = switch ($Sex) {
			'м' { 1 }
			'ж' { 2 }
			default { 0 }
		};
		$IsMailboxExists = $Mailboxes -contains $LName;
		if ( $IsMailboxExists -and ( -not $Force ) ) {
			Write-Error "Создаваемый ящик $LName на домене $DomainName уже существует. Для переопределения его реквизитов используйте параметр -Force.";
		} else {
			if ( -not $IsMailboxExists ) {
				Write-Verbose "Создаваемый ящик $LName на домене $DomainName не существует - создаём.";
				Invoke-API `
					-method 'api/reg_user' `
					-DomainName $DomainName `
					-Params @{
						login = $LName;
						passwd = $Password;
					} `
				;
			};
			if ( $PsCmdlet.ParameterSetName -eq 'ExtraAccountAttributes' ) {
				Write-Verbose "Изменяем реквизиты ящика $LName на домене $DomainName.";
				Invoke-API `
					-method 'edit_user' `
					-DomainName $DomainName `
					-Params @{
						login = $LName;
						passwd = $Password;
						iname = ( ($FirstName, $MiddleName | ? { $_ } ) -join ' ' );
						fname = $SecondName;
						sex = $SexDig;
					} `
					-IsSuccessPredicate { [bool]$_.page.ok } `
					-IsFailurePredicate { [bool]$_.page.error } `
					-FailureMsgFilter { $_.page.error.reason } `
				;
			};
		};
		
		if ( $PassThru ) { $input };
	}
}

function Edit-Mailbox {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
			Метод (обёртка над Яндекс.API edit_user) предназначен для редактирования
			сведений о пользователе ящика на "припаркованном" на Яндексе домене.
		.Description
			Метод (обёртка над Яндекс.API edit_user) предназначен для редактирования
			сведений о пользователе ящика на "припаркованном" на Яндексе домене.
			Синтаксис запроса
				https://pddimp.yandex.ru/edit_user.xml ?
				token =<токен>
				 & login =<логин пользователя>
				 & [password =<пароль пользователя>]
				 & [iname =<имя пользователя>]
				 & [fname =<фамилия пользователя>]
				 & [sex =<пол пользователя>]
				 & [hintq =<секретный вопрос>]
				 & [hinta =<ответ на секретный вопрос>]
		.Link
			http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_edit_user.xml
		.Example
			Edit-Mailbox -DomainName 'csm.nov.ru' -LName 'test_user' -Password 'testpassword';
	#>

	[CmdletBinding(
		SupportsShouldProcess=$true
		, ConfirmImpact="High"
	)]
	
	param (
		# имя домена, зарегистрированного на сервисах Яндекса
		[Parameter(
			Mandatory=$false
			, ValueFromPipelineByPropertyName=$true
		)]
		[string]
		[ValidateScript( { $_ -match "^$($reDomain)$" } )]
		[Alias("domain_name")]
		[Alias("Domain")]
		$DomainName
	,
		# Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене
		[Parameter(
			Mandatory=$true
			, ValueFromPipelineByPropertyName=$true
		)]
		[System.String]
		[ValidateNotNullOrEmpty()]
		[Alias("Email")]
		[Alias("Login")]
		[Alias("mailNickname")]
		$LName
	,
		# Пароль к создаваемой учётной записи. Может быть как зашифрованным (SecureString), так и простым текстом
		#(String)
		[Parameter(
			Mandatory=$true
			, ValueFromPipelineByPropertyName=$true
		)]
		[ValidateScript({
			[System.String] `
			, [System.Security.SecureString] `
			-contains ( $_.GetType() )
		})]
		[ValidateNotNullOrEmpty()]
		$Password
	,
		# Фамилия пользователя
		[Parameter(
			Mandatory=$false
			, ValueFromPipelineByPropertyName=$true
		)]
		[System.String]
		[ValidateNotNullOrEmpty()]
		[Alias("sn")]
		$SecondName
	,
		# Имя пользователя
		[Parameter(
			Mandatory=$false
			, ValueFromPipelineByPropertyName=$true
		)]
		[System.String]
		[ValidateNotNullOrEmpty()]
		[Alias("givenName")]
		$FirstName
	,
		# Отчество пользователя
		[Parameter(
			Mandatory=$false
			, ValueFromPipelineByPropertyName=$true
		)]
		[System.String]
		[ValidateNotNull()]
		$MiddleName
	,
		# Пол пользователя
		[Parameter(
			Mandatory=$false
			, ValueFromPipelineByPropertyName=$true
		)]
		[System.String]
		[ValidateSet("м", "ж")]
		$Sex
	,
		# передавать домены далее по конвейеру или нет
		[switch]
		$PassThru
	)

	process {
		if ( $Password -is [System.Security.SecureString] ) {
			$Credential = New-Object System.Management.Automation.PSCredential( 
				$LName, 
				$Password
			);
			$Password = $Credential.GetNetworkCredential().Password;
		};
		$Sex = switch ($Sex) {
			'м' { 1 }
			'ж' { 2 }
			default { 0 }
		};
		Write-Verbose "Изменяем реквизиты ящика $LName на домене $DomainName.";
		Invoke-API `
			-method 'edit_user' `
			-DomainName $DomainName `
			-Params @{
				login = $LName;
				passwd = $Password;
				iname = ( ($FirstName, $MiddleName | ? { $_ } ) -join ' ' );
				fname = $SecondName;
			} `
			-IsSuccessPredicate { [bool]$_.page.ok } `
			-IsFailurePredicate { [bool]$_.page.error } `
			-FailureMsgFilter { $_.page.error.reason } `
		;
		if ( $PassThru ) { $input };
	}
}

function Remove-Mailbox {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
			Метод (обёртка над Яндекс.API del_user) предназначен для удаления
			ящика на "припаркованном" на Яндексе домене.
		.Description
			Метод (обёртка над Яндекс.API del_user) предназначен для удаления
			ящика на "припаркованном" на Яндексе домене.
			Синтаксис запроса
				https://pddimp.yandex.ru/api/del_user.xml ? token =<токен>
				& domain =<имя домена> & login =<имя почтового ящика>
		.Link
			http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_del_user.xml
		.Example
			Remove-Mailbox -DomainName 'csm.nov.ru' -LName 'test_user';
	#>

	[CmdletBinding(
		SupportsShouldProcess=$true
		, ConfirmImpact="High"
	)]
	
	param (
		# имя домена, зарегистрированного на сервисах Яндекса
		[Parameter(
			Mandatory=$false
		)]
		[string]
		[ValidateScript( { $_ -match "^$($reDomain)$" } )]
		[Alias("domain_name")]
		[Alias("Domain")]
		$DomainName
	,
		# Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене
		[Parameter(
			Mandatory=$true
			, ValueFromPipeline=$true
			, Position = 0
		)]
		[System.String]
		[ValidateNotNullOrEmpty()]
		[Alias("Email")]
		[Alias("Login")]
		[Alias("mailNickname")]
		$LName
	,
		# передавать домены далее по конвейеру или нет
		[switch]
		$PassThru
	)

	process {
		Invoke-API `
			-method 'api/del_user' `
			-DomainName $DomainName `
			-Params @{
				login = $LName;
			} `
		;
		if ( $PassThru ) { $input };
	}
}

function Get-MailListMembers {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
			Метод (обёртка над Яндекс.API get_forward_list) предназначен для получения
			перенаправлений почты для ящика на "припаркованном" на Яндексе домене.
		.Description
			Метод (обёртка над Яндекс.API get_forward_list) предназначен для получения
			перенаправлений почты для ящика на "припаркованном" на Яндексе домене.
			Синтаксис запроса
				https://pddimp.yandex.ru/get_forward_list.xml ? token =<токен>
				& login =<логин пользователя>
		.Link
			http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_get_forward_list.xml
		.Example
			Get-MailListMembers -DomainName 'csm.nov.ru' -LName 'sergei.s.betke';
	#>

	[CmdletBinding(
		SupportsShouldProcess=$true
		, ConfirmImpact="Low"
	)]
	
	param (
		# имя домена, зарегистрированного на сервисах Яндекса
		[Parameter(
			Mandatory=$false
		)]
		[string]
		[ValidateScript( { $_ -match "^$($reDomain)$" } )]
		[Alias("domain_name")]
		[Alias("Domain")]
		$DomainName
	,
		# Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене
		[Parameter(
			Mandatory=$true
			, Position=0
		)]
		[System.String]
		[ValidateNotNullOrEmpty()]
		[Alias("Email")]
		[Alias("Login")]
		[Alias("mailNickname")]
		[Alias("LName")]
		[Alias("MailList")]
		$MailListLName
	)

	process {
		Invoke-API `
			-method 'get_forward_list' `
			-DomainName $DomainName `
			-Params @{
				login = $MailListLName;
			} `
			-IsSuccessPredicate { [bool]$_.page.ok } `
			-IsFailurePredicate { [bool]$_.page.error } `
			-FailureMsgFilter { $_.page.error.reason } `
			-ResultFilter { 
				$_.SelectNodes('page/ok/filters/filter') `
				| %{ $_.filter_param; } `
				| %{
					$temp = $_ -match $reMailAddr;
					$matches['lname'];
				} `
			} `
		;
	}
}

function New-MailListMember {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
			Метод (обёртка над Яндекс.API set_forward) предназначен для создания
			перенаправлений почты для ящика на "припаркованном" на Яндексе домене.
		.Description
			Метод (обёртка над Яндекс.API set_forward) предназначен для создания
			перенаправлений почты для ящика на "припаркованном" на Яндексе домене.
			Синтаксис запроса
				https://pddimp.yandex.ru/set_forward.xml ? token =<токен>
				& login =<логин пользователя>
				& address =<e-mail для пересылки>
				& copy =<признак сохранения исходников>
		.Link
			http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_set_forward.xml
		.Example
			New-MailListMember -DomainName 'csm.nov.ru' -MailListLName 'mail' -LName 'sergei.s.betke';
	#>

	[CmdletBinding(
		SupportsShouldProcess=$true
		, ConfirmImpact="Medium"
	)]
	
	param (
		# имя домена, зарегистрированного на сервисах Яндекса
		[Parameter(
			Mandatory=$false
		)]
		[string]
		[ValidateScript( { $_ -match "^$($reDomain)$" } )]
		[Alias("domain_name")]
		[Alias("Domain")]
		$DomainName
	,
		# Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене
		[Parameter(
			Mandatory=$true
		)]
		[System.String]
		[ValidateNotNullOrEmpty()]
		[Alias("MailList")]
		$MailListLName
	,
		# Адрес электронной почты (lname) на том же домене для перенаправления почты
		[Parameter(
			Mandatory=$true
			, ValueFromPipeline=$true
			, ValueFromPipelineByPropertyName=$true
		)]
		[System.String]
		[ValidateNotNullOrEmpty()]
		[Alias("Email")]
		[Alias("Login")]
		[Alias("mailNickname")]
		$LName
	,
		# передавать домены далее по конвейеру или нет
		[switch]
		$PassThru
	)

	begin {
		$MailListMembers = Get-MailListMembers `
			-DomainName $DomainName `
			-MailListLName $MailListLName `
		;
	}
	process {
		if ( $MailListMembers -notcontains $LName ) {
			$res = Invoke-API `
				-method 'set_forward' `
				-DomainName $DomainName `
				-Params @{
					login = $MailListLName;
					address = "$LName@$DomainName";
					copy = 'yes';
				} `
				-IsSuccessPredicate { [bool]$_.SelectSingleNode('page/ok'); } `
				-IsFailurePredicate { [bool]$_.page.error } `
				-FailureMsgFilter { $_.page.error.reason } `
			;
		};
		if ( $PassThru ) { return $input };
	}
}

function Remove-MailListMember {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
			Метод (обёртка над Яндекс.API delete_forward) предназначен для удаления
			перенаправлений почты для ящика на "припаркованном" на Яндексе домене.
		.Description
			Метод (обёртка над Яндекс.API delete_forward) предназначен для удаления
			перенаправлений почты для ящика на "припаркованном" на Яндексе домене.
			Синтаксис запроса
				https://pddimp.yandex.ru/delete_forward.xml ? token =<токен>
				& login =<логин пользователя>
				& filter_id =<id фильтра>
		.Link
			http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_delete_forward.xml
		.Example
			Remove-MailListMember -DomainName 'csm.nov.ru' -MailListLName 'mail' -LName 'sergei.s.betke';
	#>

	[CmdletBinding(
		SupportsShouldProcess=$true
		, ConfirmImpact="High"
	)]
	
	param (
		# имя домена, зарегистрированного на сервисах Яндекса
		[Parameter(
			Mandatory=$false
		)]
		[string]
		[ValidateScript( { $_ -match "^$($reDomain)$" } )]
		[Alias("domain_name")]
		[Alias("Domain")]
		$DomainName
	,
		# Учётная запись (lname для создаваемого ящика) на Вашем припаркованном домене
		[Parameter(
			Mandatory=$true
		)]
		[System.String]
		[ValidateNotNullOrEmpty()]
		[Alias("MailList")]
		$MailListLName
	,
		# Адрес электронной почты (lname) на том же домене для перенаправления почты
		[Parameter(
			Mandatory=$true
			, ValueFromPipeline=$true
			, ValueFromPipelineByPropertyName=$true
		)]
		[System.String]
		[ValidateNotNullOrEmpty()]
		[Alias("Email")]
		[Alias("Login")]
		[Alias("mailNickname")]
		$LName
	,
		# передавать домены далее по конвейеру или нет
		[switch]
		$PassThru
	)

	begin {
		$MailListMembers = Invoke-API `
			-method 'get_forward_list' `
			-DomainName $DomainName `
			-Params @{
				login = $MailListLName;
			} `
			-IsSuccessPredicate { [bool]$_.page.ok } `
			-IsFailurePredicate { [bool]$_.page.error } `
			-FailureMsgFilter { $_.page.error.reason } `
			-ResultFilter { 
				@(
					$_.SelectNodes('page/ok/filters/filter');
				);
			} `
		;
	}
	process {
		$id = (
			$MailListMembers `
			| ? { $_.filter_param -eq "$LName@$DomainName" } `
			| % { $_.id } `
		);
		if ( $id ) {
			Write-Verbose "Удаляемый адресат $LName обнаружен среди перенаправлений для ящика $MailListLName@$DomainName, id=$id.";
			$id `
			| % {
				Invoke-API `
					-method 'delete_forward' `
					-DomainName $DomainName `
					-Params @{
						login = $MailListLName;
						filter_id = $_;
					} `
					-IsSuccessPredicate { [bool]$_.SelectSingleNode('page/ok'); } `
					-IsFailurePredicate { [bool]$_.page.error } `
					-FailureMsgFilter { $_.page.error.reason } `
				;
			};
		} else {
			Write-Verbose "Удаляемый адресат $LName не обнаружен среди перенаправлений для ящика $MailListLName@$DomainName.";
		};
		if ( $PassThru ) { $input };
	}
}

function New-MailList {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
			Создание группы рассылки, включающей всех пользователей домена. Обёртка
			над create_general_maillist.
		.Description
			Создание группы рассылки, включающей всех пользователей домена. Обёртка
			над create_general_maillist.
			Синтаксис запроса:
				https://pddimp.yandex.ru/api/create_general_maillist.xml ? token =<токен>
				& domain =<имя домена>
				& ml_name =<имя рассылки>
		.Link
			http://api.yandex.ru/pdd/doc/api-pdd/reference/maillist_create_general_maillist.xml
		.Example
			New-MailList -DomainName 'csm.nov.ru' -MailListLName 'all';
	#>

	[CmdletBinding(
		SupportsShouldProcess=$true
		, ConfirmImpact="Medium"
	)]
	
	param (
		# имя домена, зарегистрированного на сервисах Яндекса
		[Parameter(
			Mandatory=$false
		)]
		[string]
		[ValidateScript( { $_ -match "^$($reDomain)$" } )]
		[Alias("domain_name")]
		[Alias("Domain")]
		$DomainName
	,
		# Учётная запись (lname для создаваемой группы рассылки) на Вашем припаркованном домене
		[Parameter(
			Mandatory=$true
		)]
		[System.String]
		[ValidateNotNullOrEmpty()]
		[Alias("MailList")]
		$MailListLName
	,
		# Учётная запись (lname для ящиков) на Вашем припаркованном домене, которые должны быть включены в создаваемую группу рассылки
		[Parameter(
			Mandatory=$false
			, ValueFromPipeline=$true
			, ValueFromPipelineByPropertyName=$true
		)]
		[System.String]
		[Alias("Email")]
		[Alias("Login")]
		[Alias("mailNickname")]
		$LName
	,
		[switch]
		$Force
	,
		[switch]
		$PassThru
	)

	begin {
		if ( $IsNewMailList = ( Get-Mailboxes -DomainName $DomainName ) -notcontains $MailListLName	) {
			# Яндекс не предоставил API для создания групп рассылки, кроме general
			Invoke-API `
				-method 'api/create_general_maillist' `
				-DomainName $DomainName `
				-Params @{
					ml_name = $MailListLName;
				} `
			;
			Start-Sleep -Milliseconds 3000; # дождёмся, пока Яндекс остановит асинхронный процесс добавления ящиков в группу
		};
		if ( $IsNewMailList -or $Force ) {
			if ( -not $IsNewMailList ) {
				Write-Verbose "Группу рассылки $MailListLName для домена $DomainName уже существует, переопределяем членов группы рассылки.";
			};
			Get-MailListMembers `
				-DomainName $DomainName `
				-MailListLName $MailListLName `
			| Remove-MailListMember `
				-DomainName $DomainName `
				-MailListLName $MailListLName `
			;
		} else {
			Write-Error "Невозможно создать группу рассылки $MailListLName для домена $DomainName: группа или ящик с таким адресом уже существуют.";
		};
		$NewMailListMember = ( {
			& (Get-Command New-MailListMember) `
				-DomainName $DomainName `
				-MailListLName $MailListLName `
			;
		} ).GetSteppablePipeline();
		$NewMailListMember.Begin( $true );
	}
	process {
		if ( $LName ) {
			$NewMailListMember.Process( $LName );
		};
		if ( $PassThru ) { return $input };
	}
	end {
		$NewMailListMember.End();
	}
}

function Remove-MailList {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
			Метод предназначен для удаления группы рассылки на "припаркованном" на Яндексе домене.
			Обёртка для delete_general_maillist.
		.Description
			Метод предназначен для удаления группы рассылки на "припаркованном" на Яндексе домене.
			Обёртка для delete_general_maillist.
			Синтаксис запроса:
				https://pddimp.yandex.ru/api/delete_general_maillist.xml ? token =<токен>
				& domain =<имя домена>
				& ml_name =<имя рассылки>
		.Link
			http://api.yandex.ru/pdd/doc/api-pdd/reference/maillist_delete_general_maillist.xml
		.Example
			Remove-MailList -DomainName 'csm.nov.ru' -MailListLName 'test_maillist';
	#>

	[CmdletBinding(
		SupportsShouldProcess=$true
		, ConfirmImpact="High"
	)]
	
	param (
		# имя домена, зарегистрированного на сервисах Яндекса
		[Parameter(
			Mandatory=$false
		)]
		[string]
		[ValidateScript( { $_ -match "^$($reDomain)$" } )]
		[Alias("domain_name")]
		[Alias("Domain")]
		$DomainName
	,
		# Адрес (без домена, lname) удаляемой группы рассылки на Вашем припаркованном домене
		[Parameter(
			Mandatory=$true
			, ValueFromPipeline=$true
			, Position=0
		)]
		[System.String]
		[ValidateNotNullOrEmpty()]
		[Alias("MailList")]
		$MailListLName
	)

	process {
		Invoke-API `
			-method 'api/delete_general_maillist' `
			-DomainName $DomainName `
			-Params @{
				ml_name = $MailListLName;
			} `
			-IsSuccessPredicate { -not $_.SelectSingleNode('action/status/error') } `
		;
		Remove-Mailbox `
			-DomainName $DomainName `
			-LName $MailListLName `
			-ErrorAction SilentlyContinue `
		;
	}
}

function ConvertTo-Contact {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
			Преобразует объект в конвейере в объект со свойствами контакта Яндекс.
		.Description
			Исходный объект должен обладать реквизитами контакта в соостветствии со схемой AD.
			Выходной объект уже будет обладать реквизитами контакта, ожидаемыми при импорте csv файла в ящик на Яндексе.
		.Example
			Get-ADUser `
			| ConvertTo-Contact `
			| Export-Csv 'ya.csv';
	#>

	[CmdletBinding(
		SupportsShouldProcess=$true
		, ConfirmImpact="Low"
	)]
	
	param (
		# Фамилия
		[Parameter(
			Mandatory=$false
			, ValueFromPipelineByPropertyName=$true
			, ParameterSetName="ContactProperties"
		)]
		[System.String]
		[ValidateNotNullOrEmpty()]
		[Alias("sn")]
		[Alias("SecondName")]
		[Alias("LastName")]
		$Фамилия
	,
		# Имя
		[Parameter(
			Mandatory=$false
			, ValueFromPipelineByPropertyName=$true
			, ParameterSetName="ContactProperties"
		)]
		[System.String]
		[ValidateNotNullOrEmpty()]
		[Alias("givenName")]
		[Alias("FirstName")]
		$Имя
	,
		# Отчество
		[Parameter(
			Mandatory=$false
			, ValueFromPipelineByPropertyName=$true
			, ParameterSetName="ContactProperties"
		)]
		[System.String]
		[Alias("MiddleName")]
		$Отчество
	,
		# дата рождения
		[Parameter(
			Mandatory=$false
			, ValueFromPipelineByPropertyName=$true
			, ParameterSetName="ContactProperties"
		)]
		[System.DateTime]
		[Alias("Birthday")]
		${День Рождения}
	,
		# телефон рабочий
		[Parameter(
			Mandatory=$false
			, ValueFromPipelineByPropertyName=$true
			, ParameterSetName="ContactProperties"
		)]
		[System.String]
		[Alias("telephoneNumber")]
		[Alias("BusinessTelephoneNumber")]
		${Рабочий телефон}
	,
		# адрес электронной почты
		[Parameter(
			Mandatory=$false
			, ValueFromPipelineByPropertyName=$true
			, ParameterSetName="ContactProperties"
		)]
		[System.String]
		[Alias("mail")]
		[Alias("Email1Address")]
		${Адрес эл. почты}
	)

	process {
		$PSBoundParameters `
		| ConvertFrom-Dictionary `
		| ? { (Get-Command ConvertTo-Contact).Parameters.($_.Key).ParameterSets.ContainsKey('ContactProperties') } `
		| ConvertTo-PSObject -PassThru `
		;
	}
}

Export-ModuleMember `
	Register-Domain `
	, Remove-Domain `
	, Set-DefaultEmail `
	, Set-Logo `
	, Remove-Logo `
	, Get-Mailboxes `
	, Get-Admins `
	, Register-Admin `
	, Remove-Admin `
	, New-Mailbox `
	, Edit-Mailbox `
	, Remove-Mailbox `
	, Get-MailListMembers `
	, New-MailListMember `
	, Remove-MailListMember `
	, New-MailList `
	, Remove-MailList `
	, ConvertTo-Contact `
;