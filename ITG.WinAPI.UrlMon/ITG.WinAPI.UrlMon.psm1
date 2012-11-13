Add-Type `
@"
namespace ITG.WinAPI.UrlMon {

using System; 
using System.IO; 
using System.Runtime.InteropServices; 

[Flags]
public enum FMFD {
    Default = 0x00000000, // No flags specified. Use default behavior for the function. 
    URLAsFileName = 0x00000001, // Treat the specified pwzUrl as a file name. 
    EnableMIMESniffing = 0x00000002, // Internet Explorer 6 for Windows XP SP2 and later. Use MIME-type detection even if FEATURE_MIME_SNIFFING is detected. Usually, this feature control key would disable MIME-type detection. 
    IgnoreMIMETextPlain = 0x00000004, // Internet Explorer 6 for Windows XP SP2 and later. Perform MIME-type detection if "text/plain" is proposed, even if data sniffing is otherwise disabled. Plain text may be converted to text/html if HTML tags are detected. 
    ServerMIME = 0x00000008, // Internet Explorer 8. Use the authoritative MIME type specified in pwzMimeProposed. Unless FMFD_IGNOREMIMETEXTPLAIN is specified, no data sniffing is performed. 
    RespectTextPlain = 0x00000010, // Internet Explorer 9. Do not perform detection if "text/plain" is specified in pwzMimeProposed. 
    RetrunUpdatedImgMIMEs = 0x00000020 // Internet Explorer 9. Returns image/png and image/jpeg instead of image/x-png and image/pjpeg. 
};

public
class API {

// http://msdn.microsoft.com/en-us/library/ms775107(VS.85).aspx
// http://www.rsdn.ru/article/dotnet/netTocom.xml

[DllImport(
    "urlmon.dll"
    , CharSet=CharSet.Unicode
    , ExactSpelling=true
    , SetLastError=false
)]
public
static
extern
System.UInt32 
FindMimeFromData(
	System.UInt32 pBC,
	[In,  MarshalAs(UnmanagedType.LPWStr)] System.Text.StringBuilder pwzUrl,
	[In,  MarshalAs(UnmanagedType.LPArray, ArraySubType = UnmanagedType.I1, SizeParamIndex=3)] byte[] pBuffer,
	[In,  MarshalAs(UnmanagedType.U4)] System.UInt32 cbSize,
	[In,  MarshalAs(UnmanagedType.LPWStr)] System.Text.StringBuilder pwzMimeProposed,
	[In,  MarshalAs(UnmanagedType.U4)] System.UInt32 dwMimeFlags,
	[Out, MarshalAs(UnmanagedType.LPWStr)] out String ppwzMimeOut,
	[In,  MarshalAs(UnmanagedType.U4)] System.UInt32 dwReserverd
);

}
}
"@;

function Get-MIME {
	<#
		.Synopsis
		    Функция определяет MIME тип файла по его содержимому и расширению имени файла.
		.Description
		    Функция определяет MIME тип файла по его содержимому и расширению имени файла
            (если файл недоступен).
            Обёртка для API FindMimeFromData.
        .Link
            http://msdn.microsoft.com/en-us/library/ms775107(VS.85).aspx
            http://social.msdn.microsoft.com/Forums/en-US/Vsexpressvcs/thread/d79e76e3-b8c9-4fce-a97d-94ded18ea4dd
		.Example
			"logo.jpg" | Get-MIME
	#>
    [CmdletBinding(
    )]
	
    param (
        # путь к файлу, MIME для которого необходимо определить
        [Parameter(
			Mandatory=$true,
			Position=0,
			ValueFromPipeline=$true
		)]
        [System.IO.FileInfo]$Path
	)

    process {
        try { 
            $length = 0;
            [Byte[]] $buffer = $null;
            if ( [System.IO.File]::Exists( $Path ) ) {
                Write-Verbose "Определяем MIME тип файла по его содержимому (файл $($Path.FullName) доступен).";
                $fs = New-Object System.IO.FileStream (
                    $Path, 
                    [System.IO.FileMode]::Open,
                    [System.IO.FileAccess]::Read,
                    [system.IO.FileShare]::Read,
                    256
                );
                try {
                    if ( $fs.Length -ge 256) {
                        $length = 256;
                    } else {
                        $length = $fs.Length;
                    };
                    if ( $length ) {
                        $buffer = New-Object Byte[] (256);
                        $length = $fs.Read( $buffer, 0, $length );
                    };
                } finally {
                    $fs.Dispose();
                };
            } else {
                Write-Verbose "Определяем MIME тип файла по расширению его имени (файл $($Path.FullName) недоступен).";
            };
            [string]$mime = '';
            $err = [ITG.WinAPI.UrlMon.API]::FindMimeFromData(
                0,
                $Path.FullName, 
                $buffer, 
                $length, 
                $null, 
                [ITG.WinAPI.UrlMon.FMFD]::URLAsFileName -bor [ITG.WinAPI.UrlMon.FMFD]::RetrunUpdatedImgMIMEs,
                [ref]$mime, 
                0
            );
            [System.Runtime.InteropServices.Marshal]::ThrowExceptionForHR( $err );
            $mime;
        } catch [Exception] {
            Write-Error `
                -Exception $_.Exception `
                -Message "Возникла ошибка при попытке определения MIME типа для файла $($Path.FullName)" `
            ;
        };
	}
}  

Export-ModuleMember `
    Get-MIME `
;
