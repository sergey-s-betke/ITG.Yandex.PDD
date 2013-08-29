[CmdletBinding(
	SupportsShouldProcess=$true,
	ConfirmImpact="Medium"
)]
param (
)

Import-Module `
	(Join-Path `
		-Path ( Split-Path -Path ( $MyInvocation.MyCommand.Path ) -Parent ) `
        -ChildPath 'ITG.Yandex.PDD.psd1' `
    ) `
	-Force `
;

Set-Readme `
	-ModuleInfo ( Get-Module 'ITG.Yandex.PDD' ) `
	-ReferencedModules @(
		'ITG.Yandex', 'ITG.Utils', 'ITG.WinAPI.UrlMon', 'ITG.WinAPI.User32' | Get-Module
	) `
;

Set-Token `
    -DomainName 'csm.nov.ru' `
    -Token ( ConvertTo-SecureString -String (`
        '01000000d08c9ddf0115d1118c7a00c04fc297eb010000003c7609fd8f4ca94f'+
        '9aa41d9e6632179a0000000002000000000003660000c0000000100000000703'+
        '27065085138f1f6b98a9ab0a64dd0000000004800000a00000001000000002c2'+
        '302fc1c2e3332e887342b977db7f78000000664392f87f6424cb6ae82fcf4c66'+
        'becd1a737f986c92e092a4a9055413550a9dfd3b760089811c1efcaa8da17ea6'+
        'd03c9addbdca3f608787a4487701b5e117c657bc7334c7be36c6fcb7623d915c'+
        'dfe8ae30bad6b950af7d3437062d051f2bcac5fb118472b1701d43adbf0e0281'+
        'e5904256d5f7f305212714000000aa50cbd989d1423053c51a2062c07cbdb3720c2a'
    )) `
;
$PSDefaultParameterValues['*:DomainName'] = 'csm.nov.ru';
$PSDefaultParameterValues['*:ZoneName'] = 'csm.nov.ru';


#$Token = Get-Token -ErrorAction Stop;

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