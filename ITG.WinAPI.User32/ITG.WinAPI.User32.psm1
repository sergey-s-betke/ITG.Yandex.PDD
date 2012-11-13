Add-Type @" 

using System; 
using System.IO; 
using System.Runtime.InteropServices; 

namespace ITG {

public class WinAPI { 
	
// http://msdn.microsoft.com/en-us/library/windows/desktop/ms633545(v=vs.85).aspx
[DllImport("user32.dll")] 
[return: MarshalAs(UnmanagedType.Bool)] 
public
static
extern
bool
SetWindowPos(
	[In] IntPtr hWnd, 
	[In] IntPtr hWndInsertAfter,
	[In] int x,  [In] int y, 
	[In] int cx, [In] int cy, 
	[In] uint uFlags
);

// http://msdn.microsoft.com/en-us/library/windows/desktop/ms633539(v=vs.85).aspx
[DllImport("user32.dll")] 
[return: MarshalAs(UnmanagedType.Bool)] 
public
static
extern
bool
SetForegroundWindow(
	[In] IntPtr hWnd
);
	
} 

}

"@;
