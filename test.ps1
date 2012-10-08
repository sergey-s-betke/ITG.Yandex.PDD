[CmdletBinding(
	SupportsShouldProcess=$true,
	ConfirmImpact="Medium"
)]
param ()

Import-Module `
    (join-path `
        -path ( ( [System.IO.FileInfo] ( $myinvocation.mycommand.path ) ).directory ) `
        -childPath 'ITG.Yandex.PDD' `
    ) `
	-Prefix Yandex `
	-Force `
;

$Token = Get-YandexToken 'csm.nov.ru' -ErrorAction Stop;


'csm.nov.ru' `
| Remove-YandexLogo -PassThru `
;

<#
'csm.nov.ru' `
| Register-YandexDomain `
| Add-Member `
	-MemberType NoteProperty `
	-Name DefaultEmail `
	-Value 'master' `
	-PassThru `
| Register-YandexDefaultEmail `
;
#>

# Remove-YandexDomain -DomainName 'test.ru';

Get-YandexEmails;

