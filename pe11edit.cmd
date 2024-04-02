@echo off
REM peedit.cmd for WADK11 PE 
REM it needs to be launched by DandI bat as Administrator
IF "%1"=="setenv" goto setenv
IF "%1"=="copype" goto copype
IF "%1"=="mountimg" goto mountimg
IF "%1"=="addpkg" goto addpkg
IF "%1"=="getpkg" goto getpkg
IF "%1"=="adddriver" goto adddriver
IF "%1"=="getdriver" goto getdriver
IF "%1"=="unmount" goto unmount
IF "%1"=="cancel" goto cancelmnt
IF "%1"=="makeiso" goto makeiso
IF "%1"=="makeufd" goto makeufd
IF "%1"=="" goto usageinfo
goto usageinfo

:setenv
echo setenv
set PE_ARCH=amd64
set PE_BASE=C:\yourwork\path
set PE_WIM=%PE_BASE%\media\sources\boot.wim
set PE_MOUNT=%PE_BASE%\mount

echo PE_ARCH=%PE_ARCH%
echo PE_BASE=%PE_BASE%
echo PE_WIM=%PE_WIM%
echo PE_MOUNT=%PE_MOUNT%
goto END

:copype
copype %PE_ARCH% %PE_BASE%
goto END

:mountimg
Dism /Mount-Image /ImageFile:"%PE_WIM%" /index:1 /MountDir:"%PE_MOUNT%"
goto END

:addpkg
Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\WinPE-FontSupport-JA-JP.cab"
Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\ja-jp\lp.cab"

Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\WinPE-PlatformId.cab"

Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\WinPE-NetFx.cab
Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\ja-jp\WinPE-NetFx_ja-jp.cab

Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\WinPE-WMI.cab
Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\ja-jp\WinPE-WMI_ja-jp.cab

Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\WinPE-PowerShell.cab
Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\ja-jp\WinPE-PowerShell_ja-jp.cab

Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\WinPE-Scripting.cab
Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\ja-jp\WinPE-Scripting_ja-jp.cab

Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\WinPE-SecureStartup.cab
Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\ja-jp\WinPE-SecureStartup_ja-jp.cab

Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\WinPE-SecureBootCmdlets.cab

Dism /Set-AllIntl:ja-JP /Image:"%PE_MOUNT%"
goto END

:getpkg
Dism /Get-Packages /Image:"%PE_MOUNT%"
Dism /Get-Intl /Image:"%PE_MOUNT%"
goto END


:adddriver
echo JUST a guidance
echo  Run: Dism /Add-Driver /Image:"%PE_MOUNT%" /driver:C:PATH\TO\DRIVERS  /recurse 
goto END

:getdriver
Dism /Get-Drivers /Image:"%PE_MOUNT%"
goto END

:unmount
Dism /Unmount-Image /MountDir:"%PE_MOUNT%" /commit
goto END

:cancelmnt
Dism /Unmount-Image /MountDir:"%PE_MOUNT%" /discard
goto END

:makeiso
MakeWinPEMedia /ISO "%PE_BASE%" %PE_BASE%\bootpe_%PE_ARCH%.iso
goto END

:makeufd
echo JUST a guidance
echo Run: MakeWinPEMedia /UFD "%PE_BASE%" USBDRIVELETTER: 
goto END

:usageinfo
echo setenv    - set variables like PE_BASE path
echo copype    - copy image into working path.
echo mountimg  - mount this PE wim image.
echo addpkg    - add optional components into mounted image.
echo getpkg    - list optional component added.
echo adddriver - show guide to inject drivers.
echo getdriver - show injected drivers.
echo unmount   - commit and unmount
echo cancel    - discard and unmount
echo makeiso   - make iso file from this pe image.
echo makeufd   - show guide to write pe image into USB.
goto END

:END
