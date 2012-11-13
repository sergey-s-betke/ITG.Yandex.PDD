[CmdletBinding(
	SupportsShouldProcess=$true,
	ConfirmImpact="Medium"
)]
param ()

Import-Module `
	(Join-Path `
        -Path ( ( [System.IO.FileInfo] ( $MyInvocation.MyCommand.Path ) ).Directory ) `
        -ChildPath 'ITG.WinAPI' `
    ) `
	-Force `
;