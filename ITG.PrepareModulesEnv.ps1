<#
	.Synopsis
	    Скрипт, вызываемый при загрузке модулей ITG. Выполняет подготовку для загрузки модулей ITG.
	.Description
	    Скрипт, вызываемый при загрузке модулей ITG. Выполняет подготовку для загрузки модулей ITG.
		На данном этапе:
		- добавляет в $env:PSModulePath каталог загружаемого модуля, чтобы все зависимости могли быть 
		импортированы без указания полного пути (то есть - в том числе и из общего репозитория модулей
		powerShell)
    .Link
		описание манифеста модуля: http://get-powershell.com/post/2011/04/04/How-to-Package-and-Distribute-PowerShell-Cmdlets-Functions-and-Scripts.aspx
#>
[CmdletBinding(
)]
param ()

Write-Verbose "Добавляем каталог $( ( [System.IO.FileInfo] ( $myinvocation.mycommand.path ) ).directory ) в `$Env:PSModulePath.";

$Env:PSModulePath = (
	@( $env:psmodulepath -split ';' ) `
	+ ( ( [System.IO.FileInfo] ( $myinvocation.mycommand.path ) ).directory ) `
	| Select-Object -Unique `
) -join ';';

Write-Verbose @"
Изменённое значение `$Env:PSModulePath:
$(
(
	@( $env:psmodulepath -split ';' ) `
	| %{ "`t" + $_ } `
) -join "`n"
)
"@
;
