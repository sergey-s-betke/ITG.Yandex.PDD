[CmdletBinding(
	SupportsShouldProcess=$true,
	ConfirmImpact="Medium"
)]
param (
	# имя домена - любой из доменов, зарегистрированных под Вашей учётной записью на сервисах Яндекса
	[Parameter()]
    [string]
	[ValidateScript( { $_ -match "^$($reDomain)$" } )]
	[Alias("domain_name")]
	[Alias("Domain")]
	$DomainName = 'csm.nov.ru'
)

Import-Module `
    (join-path `
        -path ( ( [System.IO.FileInfo] ( $myinvocation.mycommand.path ) ).directory ) `
        -childPath 'ITG.Yandex.PDD' `
    ) `
	-Prefix Yandex `
	-Force `
;

$Token = Get-YandexToken $DomainName -ErrorAction Stop;

<#
$DomainName `
| Register-YandexDomain `
| Add-Member `
	-MemberType NoteProperty `
	-Name DefaultEmail `
	-Value 'master' `
	-PassThru `
| Register-YandexDefaultEmail `
;
#>

# Remove-YandexDomain -DomainName $DomainName;

<#
$DomainName `
| Remove-YandexLogo -PassThru `
| Set-YandexLogo `
    -Path (join-path `
        -path ( ( [System.IO.FileInfo] ( $myinvocation.mycommand.path ) ).directory ) `
        -childPath 'ITG.WinAPI.UrlMon\test\logo.jpg' `
    ) `
;
#>

<#
'csm.nov.ru' `
| Register-YandexAdmin 'sergei.e.gushchin' -PassThru `
| Get-YandexAdmins;
#>
<#
'csm.nov.ru' `
| Remove-YandexAdmin 'sergei.e.gushchin' -PassThru `
| Get-YandexAdmins;
#>

<#
@{ lname='testuser'; password='testpassword'; } `
, @{ lname='testuser2'; password='testpassword2'; } `
| Select-Object -Property `
    @{ name='lname'; expression={ $_.lname; } } `
    , @{ name='password'; expression={ $_.password; } } `
    , @{ name='sn'; expression={ 'Иванов'; } } `
    , @{ name='givenName'; expression={ 'Иван'; } } `
    , @{ name='middleName'; expression={ 'Иванович' } } `
| New-YandexMailbox `
;
#>

<#
'sergei.s.betke' `
, 'sergei.e.gushchin' `
| New-YandexMailList `
    -DomainName 'csm.nov.ru' `
    -LName 'test-maillist' `
;
#>
<#
New-YandexMailList `
    -DomainName 'csm.nov.ru' `
    -LName 'test-maillist2' `
    -Member 'sergei.s.betke', 'sergei.e.gushchin' `

;
#>
<#
Get-YandexForwards 'postmaster' `
| % { $_.filter_param } `
;
#>
#Remove-YandexMailList 'test-maillist', 'test-maillist2';

#Get-YandexMailboxes;

<#
Remove-YandexForward `
    -LName 'postmaster' `
    -DestLName 'sergei.e.gushchin' `
;
#>
New-YandexForward `
    -LName 'postmaster' `
    -DestLName 'sergei.e.gushchin' `
;
Get-YandexForwards 'postmaster' `
| % { $_.filter_param } `
;
