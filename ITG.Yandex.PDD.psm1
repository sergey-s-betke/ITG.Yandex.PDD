'ITG.WinAPI.User32' `
, 'ITG.WinAPI.UrlMon' `
, 'ITG.RegExps' `
| Import-Module;

Set-Variable `
    -Name DefaultDomain `
    -Value ([string]'') `
	-Scope Global `
;
Set-Variable `
    -Name DefaultToken `
    -Value ([string]'') `
	-Scope Global `
;

Set-Variable `
	-Name APIRoot `
	-Option Constant `
	-Value 'https://pddimp.yandex.ru' `
;

function Get-Token {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
		    Метод (обёртка над Яндекс.API get_token) предназначен для получения авторизационного токена.
		.Description
			Метод get_token предназначен для получения авторизационного токена.
			Авторизационный токен используется для активации API Яндекс.Почты для доменов. Получать токен
			нужно только один раз. Чтобы получить токен, следует иметь подключенный домен, авторизоваться
			его администратором.
			Синтаксис запроса:
				https://pddimp.yandex.ru/get_token.xml ? domain_name =<имя домена>
			Получение токена для домена yourdomain.ru:
				https://pddimp.yandex.ru/get_token.xml?domain_name=yourdomain.ru
			Формат ответа
			Если ошибок нет, метод возвращает <ok token="..."/>, в противном случае - <error reason='...'/>.
			Но данная функция возвращает непосредственно токен, либо генерирует исключение.
		.Outputs
			[System.String] - собственно token
		.Link
			http://api.yandex.ru/pdd/doc/api-pdd/reference/get-token.xml#get-token
		.Example
			Получение токена для домена yourdomain.ru:
			$token = Get-Token -DomainName 'yourdomain.ru';
	#>

	[CmdletBinding()]
    
    param (
		# имя домена - любой из доменов, зарегистрированных под Вашей учётной записью на сервисах Яндекса
		[Parameter(
			Mandatory=$true,
			Position=0,
			ValueFromPipeline=$true,
			ValueFromRemainingArguments=$true
		)]
        [string]
		[ValidateScript( { $_ -match "^$($reDomain)$" } )]
		[Alias("domain_name")]
		[Alias("Domain")]
		$DomainName = $DefaultDomain
	)

	process {
		$global:DefaultDomain = $DomainName;
		$get_tokenURI = [System.Uri]"$APIRoot/get_token.xml?domain_name=$( [System.Uri]::EscapeDataString( $DomainName ) )";
		$get_tokenAuthURI = [System.Uri]"https://passport.yandex.ru/passport?mode=auth&msg=pdd&retpath=$( [System.Uri]::EscapeDataString( $get_tokenURI ) )";

		try {
			Write-Verbose 'Создаём экземпляр InternetExplorer.';
			$ie = New-Object -Comobject InternetExplorer.application;
			Write-Verbose "Отправляем InternetExplorer на Яндекс.Паспорт ($get_tokenAuthURI).";
			$ie.Navigate( $get_tokenAuthURI );
			$ie.Visible = $True;
			
			$ie `
			| Set-WindowZOrder -ZOrder ( [ITG.WinAPI.User32.HWND]::Top ) -PassThru `
			| Set-WindowForeground `
			;

			Write-Verbose 'Ждём либо пока Яндекс.Паспорт сработает по cookies, либо пока администратор авторизуется на Яндекс.Паспорт...';
			while ( `
			    $ie.Busy `
			    -or (-not ([System.Uri]$ie.LocationURL).IsBaseOf( $get_tokenURI ) ) `
			) { Sleep -milliseconds 100; };
			$ie.Visible = $False;

			$res = ( [xml]$ie.document.documentElement.innerhtml );
			Write-Debug "Ответ API get_token: $($ie.document.documentElement.innerhtml).";
			if ( $res.ok ) {
				$token = $res.ok.token;
				Write-Verbose "Получили токен для домена $($DomainName): $token.";
				$token;
				$global:DefaultToken = $token;
			} else {
				$errMsg = $res.error.reason;
				Write-Error `
					-Message "Ответ API get_token для домена $DomainName отрицательный." `
					-Category PermissionDenied `
					-CategoryReason $errMsg `
					-CategoryActivity 'Yandex.API.get_token' `
					-CategoryTargetName $DomainName `
					-RecommendedAction 'Проверьте правильность указания домена и Ваши права на домен.' `
				;
			};
		} finally {
			Write-Verbose 'Уничтожаем экземпляр InternetExplorer.';
			$ie.Quit(); 
			$res = [System.Runtime.InteropServices.Marshal]::ReleaseComObject( $ie );
		};
	}
};

function Test-Token {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
		    Метод - проверяет действительность переданного токена (на самом деле - лишь сравнивает с пустой
			строкой, и в случае недействительности запрашивает его через Get-Token.
		.Description
		    Метод - проверяет действительность переданного токена (на самом деле - лишь сравнивает с пустой
			строкой, и в случае недействительности запрашивает его через Get-Token.
		.Outputs
			[System.String] - собственно token
		.Link
			Get-Token
		.Example
			$token = Test-Token -DomainName 'yourdomain.ru';
	#>

	[CmdletBinding()]
    
    param (
		# имя домена - любой из доменов, зарегистрированных под Вашей учётной записью на сервисах Яндекса
		[Parameter(
		)]
        [string]
		[ValidateScript( { $_ -match "^$($reDomain)$" } )]
		[Alias("domain_name")]
		[Alias("Domain")]
		$DomainName = $DefaultDomain
	,
		# авторизационный токен, полученный через Get-Token. Если не указан, то будет запрошен автоматически
		# через вызов Get-Token
		[Parameter(
		)]
        [string]
		[AllowEmptyString()]
		$Token = $DefaultToken
	)

	if ( $DomainName -ne $DefaultDomain ) {
		$global:DefaultDomain = $DomainName;
		$Token = Get-Token $DomainName;
		$global:DefaultToken = $Token;
		$Token;
	} elseif ( $DefaultToken ) {
		$DefaultToken;
	} else {
		Get-Token -DomainName $DomainName;
	};
};

function Invoke-API {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
		    Обёртка для вызовов методов API Яндекс.Почты для доменов.
		.Description
		    Обёртка для вызовов методов API Яндекс.Почты для доменов.
		.Outputs
			[xml] - Результат, возвращённый API.
	#>

	[CmdletBinding(
		SupportsShouldProcess=$true,
        ConfirmImpact="Medium"
	)]
    
    param (
		# HTTP метод вызова API.
		[Parameter(
			Mandatory=$false
		)]
		[string]
		$HttpMethod = [System.Net.WebRequestMethods+HTTP]::Get
	,
		# авторизационный токен, полученный через Get-Token.
		[Parameter(
			Mandatory=$true
		)]
        [string]
		$Token
	,
		# метод API - компонент url.
		[Parameter(
			Mandatory=$true
		)]
        [string]
		$method
	,
		# имя домена для регистрации на сервисах Яндекса
		[Parameter(
			Mandatory=$true
		)]
        [string]
		$DomainName
	,
		# коллекция параметров метода API
		[AllowEmptyCollection()]
		[System.Collections.IDictionary]
		$Params = @{}
	,
		# предикат успешного выполнения метода API
		[scriptblock]
		$IsSuccessPredicate = { [bool]$_.action.status.success }
	,
		# предикат ошибки при выполнении метода API. Если ни один из предикатов не вернёт $true - генерируем неизвестную ошибку
		[scriptblock]
		$IsFailurePredicate = { [bool]$_.action.status.error }
	,
		# фильтр обработки результата. Если фильтр не задан - функция не возвращает результат.
		[scriptblock]
		$ResultFilter = {}
	,
		# Шаблон сообщения об успешном выполнении API.
		[string]
		$SuccessMsg = "Метод API $method успешно выполнен для домена $DomainName."
	,
		# Шаблон сообщения об ошибке вызова API.
		[string]
		$FailureMsg = "Ошибка при вызове метода API $method для домена $DomainName"
	,
		# Фильтр обработки результата для выделения сообщения об ошибке.
		[scriptblock]
		$FailureMsgFilter = { $_.action.status.error.'#text' }
	,
		# Шаблон сообщения о недиагностируемой ошибке вызова API.
		[string]
		$UnknownErrorMsg = "Неизвестная ошибка при вызове метода API $method для домена $DomainName."
	)

	$Params.Add( 'token', $Token );
	$Params.Add( 'domain', $DomainName );
	
	switch ( $HttpMethod ) {
		( [System.Net.WebRequestMethods+HTTP]::Get ) {
			$escapedParams = (
				$Params.keys `
				| % { "$_=$([System.Uri]::EscapeDataString($Params.$_))" } `
			) -join '&';
			$apiURI = [System.Uri]"$APIRoot/$method.xml?$escapedParams";
			$wc = New-Object System.Net.WebClient;
			$WebMethodFunctional = { 
				$wc.DownloadString( $apiURI );
			};
		}
		( [System.Net.WebRequestMethods+HTTP]::Post ) {
			$apiURI = [System.Uri] "$APIRoot/$method.xml"; ## -replace 'https://', 'http://'
			
			$WebMethodFunctional = { 
				$wreq = [System.Net.WebRequest]::Create( $apiURI );
				$wreq.Method = $HttpMethod;
				$boundary = "##params-boundary##";
				$wreq.ContentType = "multipart/form-data; boundary=$boundary";
				$reqStream = $wreq.GetRequestStream();
				$writer = New-Object System.IO.StreamWriter( $reqStream );
                $writer.AutoFlush = $true;
                
				foreach( $param in $Params.keys ) {
                    Write-Debug ( $Params.$param -is [System.IO.FileInfo] );
                	if ( $Params.$param -is [System.IO.FileInfo] ) {
       					$writer.Write( @"
--$boundary
Content-Disposition: form-data; name="$param"; filename="$($Params.$param.Name)"
Content-Type: $(Get-MIME ($Params.$param))

"@
	        			);
                        $fs = New-Object System.IO.FileStream (
                            $Params.$param.FullName, 
                            [System.IO.FileMode]::Open,
                            [System.IO.FileAccess]::Read,
                            [system.IO.FileShare]::Read
                        );
                        $fs.CopyTo( $reqStream );
                        $fs.Close();
    					$writer.WriteLine();
                    } else {
        				$writer.Write( @"
--$boundary
Content-Disposition: form-data; name="$param"

$($Params.$param)

"@
		        		);
                    };
				};
				$writer.Write( @"
--$boundary--

"@ );
				#[char[]] $buffer = ([System.Text.Encoding]::ASCII).GetBytes( $x );
				#$writer.Write( $buffer, 0, $buffer.Length );

				$writer.Close();
				$reqStream.Close();

				$wres = $wreq.GetResponse();
				$resStream = $wres.GetResponseStream();
	            $reader = New-Object System.IO.StreamReader ( $resStream );
				$responseFromServer = [string]( $reader.ReadToEnd() );

				$reader.Close();
				$resStream.Close();
				$wres.Close();				

				$responseFromServer;
			};
<#
private void WriteMultipartFormData(Stream requestStream)
		{
			foreach (var param in Parameters)
			{
				WriteStringTo(requestStream, GetMultipartFormData(param));
			}

			foreach (var file in Files)
			{
				// Add just the first part of this param, since we will write the file data directly to the Stream
				WriteStringTo(requestStream, GetMultipartFileHeader(file));

				// Write the file data directly to the Stream, rather than serializing it to a string.
				file.Writer(requestStream);
				WriteStringTo(requestStream, _lineBreak);
			}

			WriteStringTo(requestStream, GetMultipartFooter());
		}

#>
		}
	};
	if ( $PSCmdlet.ShouldProcess( $DomainName, "Yandex.API.PDD::$method" ) ) {
		try {
			Write-Verbose "Вызов API $method для домена $($DomainName): $apiURI.";
			$resString = ( [string] ( & $WebMethodFunctional ) );
			Write-Debug "Ответ API $method: $($resString).";
			$res = [xml] $resString;
		
			$_ = $res;
			if ( & $IsSuccessPredicate ) {
				Write-Verbose $SuccessMsg;
				& $ResultFilter;
			} elseif ( & $IsFailurePredicate ) {
				Write-Error `
					-Message "$FailureMsg - ($( & $FailureMsgFilter ))" `
					-Category CloseError `
					-CategoryActivity 'Yandex.API' `
					-RecommendedAction 'Проверьте правильность указания домена и Ваши права на домен.' `
				;
			} else { # недиагностируемая ошибка вызова API
				Write-Error `
					-Message $UnknownErrorMsg `
					-Category InvalidResult `
					-CategoryActivity 'Yandex.API' `
					-RecommendedAction 'Проверьте параметры.' `
				;
			};
		} catch {
			Write-Error `
				-Message "$UnknownErrorMsg ($($_.Exception.Message))." `
				-Category InvalidOperation `
				-CategoryActivity 'Yandex.API' `
			;
		};
	};
}  

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
		$DomainName = $DefaultDomain
	,
		# авторизационный токен, полученный через Get-Token. Если не указан, то будет использован
		# последний полученный
		[Parameter(
		)]
        [string]
		[AllowEmptyString()]
		$Token
	)

	process {
		Invoke-API `
			-method 'api/reg_domain' `
			-Token ( Test-Token $DomainName $Token ) `
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
		)]
        [string]
		[AllowEmptyString()]
		$Token
	,
		# передавать домены далее по конвейеру или нет
		[switch]
		$PassThru
	)

	process {
		Invoke-API `
			-method 'api/del_domain' `
			-Token ( Test-Token $DomainName $Token ) `
			-DomainName $DomainName `
			-SuccessMsg "Домен $($DomainName) успешно отключен." `
		;
		if ( $PassThru ) { $input };
	}
}  

function Register-DefaultEmail {
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
			Register-DefaultEmail -DomainName 'csm.nov.ru' -LName 'master';
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
		$DomainName = $DefaultDomain
	,
		# авторизационный токен, полученный через Get-Token. Если не указан, то будет использован
		# последний полученный
		[Parameter(
		)]
        [string]
		[AllowEmptyString()]
		$Token
	,
		# имя почтового ящика. Ящик с именем lname должен уже существовать
		[Parameter(
			Mandatory=$true,
			ValueFromPipelineByPropertyName=$true
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
			-Token ( Test-Token $DomainName $Token ) `
			-DomainName $DomainName `
			-Params @{
				login = $LName
			} `
			-IsSuccessPredicate { [bool]$_.action.status.'action-status'.get_item('success') } `
			-IsFailurePredicate { [bool]$_.action.status.'action-status'.get_item('error') } `
			-FailureMsgFilter { $_.action.status.'action-status'.error.'#text' } `
			-ResultFilter { 
				$_.action.domains.domain `
				| Select-Object -Property `
					@{Name='DomainName'; Expression={$_.name}}`
					, @{Name='DefaultEmail'; Expression={$_.'default-email'.'#text'}} `
			} `
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
        ConfirmImpact="Medium"
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
		$DomainName = $DefaultDomain
	,
		# авторизационный токен, полученный через Get-Token. Если не указан, то будет запрошен автоматически
		# через вызов Get-Token
		[Parameter(
		)]
        [string]
		[AllowEmptyString()]
		$Token
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
			-Token ( Test-Token $DomainName $Token ) `
			-DomainName $DomainName `
			-Params @{
				file = $Path
			} `
			-SuccessMsg "Логотип для домена $($DomainName) установлен." `
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
        ConfirmImpact="Medium"
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
		$DomainName = $DefaultDomain
	,
		# авторизационный токен, полученный через Get-Token. Если не указан, то будет запрошен автоматически
		# через вызов Get-Token
		[Parameter(
		)]
        [string]
		[AllowEmptyString()]
		$Token
	,
		# передавать домены далее по конвейеру или нет
		[switch]
		$PassThru
	)

	process {
		Invoke-API `
			-method 'api/del_logo' `
			-Token ( Test-Token $DomainName $Token ) `
			-DomainName $DomainName `
			-SuccessMsg "Логотип для домена $($DomainName) удалён." `
		;
		if ( $PassThru ) { $input };
	}
}  

function Get-Emails {
	<#
		.Component
			API Яндекс.Почты для доменов
		.Synopsis
		    Метод (обёртка над Яндекс.API reg_domain_users) Метод позволяет получить список почтовых ящиков.
		.Description
		    Метод (обёртка над Яндекс.API reg_domain_users) Метод позволяет получить список почтовых ящиков.
			Метод возвращает список ящиков в домене, привязанном к токену. 
			Синтаксис запроса
				https://pddimp.yandex.ru/get_domain_users.xml ? token =<токен> & on_page =<число записей на странице> & page =<номер страницы>
		.Link
			http://api.yandex.ru/pdd/doc/api-pdd/reference/domain-control_get_domain_users.xml
		.Example
			Get-Emails -DomainName 'csm.nov.ru';
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
		$DomainName = $DefaultDomain
	,
		# авторизационный токен, полученный через Get-Token. Если не указан, то будет использован
		# последний полученный
		[Parameter(
		)]
        [string]
		[AllowEmptyString()]
		$Token
	)

	process {
		Invoke-API `
			-method 'get_domain_users' `
			-Token ( Test-Token $DomainName $Token ) `
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
				;
			} `
		;
	}
}  

Export-ModuleMember `
    Get-Token `
	, Register-Domain `
	, Remove-Domain `
	, Register-DefaultEmail `
	, Set-Logo `
	, Remove-Logo `
	, Get-Emails `
;
