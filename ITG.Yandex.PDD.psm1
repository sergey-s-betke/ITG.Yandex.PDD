'ITG.Yandex' `
, 'ITG.RegExps' `
, 'ITG.Utils' `
| Import-Module;

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
		.Link
			[reg_default_user]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-control_reg_default_user.xml
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
		# имя почтового ящика. Ящик с именем `$LName` должен уже существовать
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

function Get-Mailbox {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
			Метод (обёртка над Яндекс.API get_domain_users) Метод позволяет получить список почтовых ящиков.
		.Description
			Метод (обёртка над Яндекс.API get_domain_users) Метод позволяет получить список почтовых ящиков.
			Метод возвращает список ящиков в домене, привязанном к токену.
		.Link
			[get_domain_users]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-control_get_domain_users.xml
		.Example
			Get-Mailbox -DomainName 'csm.nov.ru';
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
};

New-Alias -Name Get-Mailboxes -Value Get-Mailbox;

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
		.Link
			[reg_user]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_reg_user.xml
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
		$Mailboxes = @( Get-Mailbox -DomainName $DomainName );
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
		.Link
			[edit_user]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_edit_user.xml
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
		.Link
			[del_user]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_del_user.xml
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

function Get-MailListMember {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
			Метод (обёртка над Яндекс.API get_forward_list) предназначен для получения
			перенаправлений почты для ящика на "припаркованном" на Яндексе домене.
		.Description
			Метод (обёртка над Яндекс.API get_forward_list) предназначен для получения
			перенаправлений почты для ящика на "припаркованном" на Яндексе домене.
		.Link
			[get_forward_list]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_get_forward_list.xml
		.Example
			Get-MailListMember -DomainName 'csm.nov.ru' -LName 'sergei.s.betke';
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
};

New-Alias -Name Get-MailListMembers -Value Get-MailListMember;

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
		.Link
			[set_forward]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_set_forward.xml
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
		$MailListMembers = Get-MailListMember `
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
	end {
	}
}

New-Alias -Name Add-MailListMember -Value New-MailListMember;

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
		.Link
			[delete_forward]: http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-users_delete_forward.xml
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
		.Link
			[create_general_maillist]: http://api.yandex.ru/pdd/doc/api-pdd/reference/maillist_create_general_maillist.xml
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
			, ParameterSetName = 'Members'
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
		if ( $IsNewMailList = ( Get-Mailbox -DomainName $DomainName ) -notcontains $MailListLName	) {
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
			Get-MailListMember `
				-DomainName $DomainName `
				-MailListLName $MailListLName `
			| Remove-MailListMember `
				-DomainName $DomainName `
				-MailListLName $MailListLName `
			;
		} else {
			Write-Verbose "Группу рассылки $MailListLName для домена $DomainName уже существует, переопределяем членов группы рассылки.";
		};
	}
	process {
		if ( $PSCmdlet.ParameterSetName -eq 'Members' ) {
			if ( -not $NewMailListMember ) {
				$NewMailListMember = ( {
					New-MailListMember `
						-DomainName $DomainName `
						-MailListLName $MailListLName `
					;
				} ).GetSteppablePipeline( $myInvocation.CommandOrigin );
				$NewMailListMember.Begin( $PSCmdlet );
			};
			$NewMailListMember.Process( $LName );
			if ( $PassThru ) { return $input };
		};
	}
	end {
		if ( $NewMailListMember ) {
			$NewMailListMember.End();
		};
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
		.Link
			[delete_general_maillist]: http://api.yandex.ru/pdd/doc/api-pdd/reference/maillist_delete_general_maillist.xml
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
			Выходной объект уже будет обладать реквизитами контакта, ожидаемыми при импорте 
			csv файла в ящик на Яндексе.
		.Example
			Get-ADUser | ConvertTo-Contact | Export-Csv 'ya.csv';
	#>

	[CmdletBinding(
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
	-Alias `
		Get-Admins `
		, Get-Mailboxes `
		, Get-MailListMembers `
		, Add-MailListMember `
	-Function `
		Register-Domain `
		, Remove-Domain `
		, Set-DefaultEmail `
		, Set-Logo `
		, Remove-Logo `
		, Get-Admin `
		, Register-Admin `
		, Remove-Admin `
		, Get-Mailbox `
		, New-Mailbox `
		, Edit-Mailbox `
		, Remove-Mailbox `
		, Get-MailListMember `
		, New-MailListMember `
		, Remove-MailListMember `
		, New-MailList `
		, Remove-MailList `
		, ConvertTo-Contact `
;