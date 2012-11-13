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
	-Force `
	-PassThru `
| Get-Readme -OutDefaultFile;

#$Token = Get-Token $DomainName -ErrorAction Stop;

<#
$DomainName `
| Register-Domain `
| Add-Member `
	-MemberType NoteProperty `
	-Name DefaultEmail `
	-Value 'master' `
	-PassThru `
| Register-DefaultEmail `
;
#>

# Remove-Domain -DomainName $DomainName;

<#
$DomainName `
| Remove-Logo -PassThru `
| Set-Logo `
    -Path (join-path `
        -path ( ( [System.IO.FileInfo] ( $myinvocation.mycommand.path ) ).directory ) `
        -childPath 'ITG.WinAPI.UrlMon\test\logo.jpg' `
    ) `
;
#>

<#
'csm.nov.ru' `
| Register-Admin 'sergei.e.gushchin' -PassThru `
| Get-Admins;
#>
<#
'csm.nov.ru' `
| Remove-Admin 'sergei.e.gushchin' -PassThru `
| Get-Admins;
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
| New-Mailbox `
;
#>

<#
'sergei.s.betke' `
, 'sergei.e.gushchin' `
| New-MailList `
    -DomainName 'csm.nov.ru' `
    -LName 'test-maillist' `
;
#>
<#
New-MailList `
    -DomainName 'csm.nov.ru' `
    -LName 'test-maillist2' `
    -Member 'sergei.s.betke', 'sergei.e.gushchin' `

;
#>
<#
Get-Forwards 'postmaster' `
| % { $_.filter_param } `
;
#>
#Remove-MailList 'test-maillist', 'test-maillist2';

#Get-Mailboxes;

<#
Remove-Forward `
    -LName 'postmaster' `
    -DestLName 'sergei.e.gushchin' `
;
#>
#New-Forward `
#    -LName 'postmaster' `
#    -DestLName 'sergei.e.gushchin' `
#;
#Get-Forward 'postmaster' `
#| % { $_.filter_param } `
#;
#