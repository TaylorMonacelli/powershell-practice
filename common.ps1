function Set-WindowSize {
    Param([int]$x=$host.ui.rawui.windowsize.width,
	  [int]$y=$host.ui.rawui.windowsize.heigth)

    $size=New-Object System.Management.Automation.Host.Size($x,$y)
    $host.ui.rawui.WindowSize=$size
}

# http://gallery.technet.microsoft.com/scriptcenter/Set-the-PowerShell-Console-bd8b2ad1
function Global:Set-MaxWindowSize
{

    if ($Host.Name -match "console")
    {
	$MaxHeight = $host.UI.RawUI.MaxPhysicalWindowSize.Height
	$MaxWidth = $host.UI.RawUI.MaxPhysicalWindowSize.Width

	$MyBuffer = $Host.UI.RawUI.BufferSize
	$MyWindow = $Host.UI.RawUI.WindowSize

	$MyWindow.Height = ($MaxHeight)
	$MyWindow.Width = ($Maxwidth-2)

	$MyBuffer.Height = (9999)
	$MyBuffer.Width = ($Maxwidth-2)

	$host.UI.RawUI.set_bufferSize($MyBuffer)
	$host.UI.RawUI.set_windowSize($MyWindow)
    }

    $CurrentUser = [Security.Principal.WindowsIdentity]::GetCurrent()

    $CurrentUserPrincipal = New-Object `
      Security.Principal.WindowsPrincipal $CurrentUser

    $Adminrole = [Security.Principal.WindowsBuiltinRole]::Administrator
    If (($CurrentUserPrincipal).IsInRole($AdminRole)){$Elevated = "Administrator"}

    $Title = $Elevated + " $ENV:USERNAME".ToUpper() + ": $($Host.Name) " + $($Host.Version) + " - " + (Get-Date).toshortdatestring()
    $Host.UI.RawUI.set_WindowTitle($Title)

}
