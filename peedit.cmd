@echo off

IF "%1"=="setenv" goto setenv
IF "%1"=="copype" goto copype
IF "%1"=="mountimg" goto mountimg
IF "%1"=="addpkg" goto addpkg
IF "%1"=="getpkg" goto getpkg
IF "%1"=="unmount" goto unmount
IF "%1"=="makeiso" goto makeiso
IF "%1"=="" goto END

:setenv
echo setenv
set PE_ARCH=x86
set PE_BASE=C:\hack\pettt
set PE_WIM=%PE_BASE%\media\sources\boot.wim
set PE_MOUNT=%PE_BASE%\mount
echo PE_ARCH=%PE_ARCH%
echo PE_BASE=%PE_BASE%
echo PE_WIM=%PE_WIM%
echo PE_MOUNT=%PE_MOUNT%
goto END

:copype
copype x86 %PE_BASE%
md %PE_MOUNT%\windows\custom
goto END

:mountimg
Dism /Mount-Image /ImageFile:"%PE_WIM%" /index:1 /MountDir:"%PE_MOUNT%"
goto END

:addpkg
Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\WinPE-FontSupport-JA-JP.cab"
Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\ja-jp\lp.cab"

Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\WinPE-HTA.cab"
Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\ja-jp\WinPE-HTA_ja-jp.cab"

Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\WinPE-Scripting.cab
Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\ja-jp\WinPE-Scripting_ja-jp.cab

Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\WinPE-NetFx4.cab
Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\ja-jp\WinPE-NetFx4_ja-jp.cab

Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\WinPE-WMI.cab
Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\ja-jp\WinPE-WMI_ja-jp.cab

Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\WinPE-PowerShell3.cab
Dism /Add-Package /Image:"%PE_MOUNT%" /PackagePath:"%WinPERoot%\%PE_ARCH%\WinPE_OCs\ja-jp\WinPE-PowerShell3_ja-jp.cab

Dism /Set-AllIntl:ja-JP /Image:"%PE_MOUNT%"
goto END

:getpkg
Dism /Get-Packages /Image:"%PE_MOUNT%"
Dism /Get-Intl /Image:"%PE_MOUNT%"
goto END

:unmount
Dism /Unmount-Image /MountDir:"%PE_MOUNT%" /commit
goto END

:makeiso
MakeWinPEMedia /ISO "%PE_BASE%" %PE_BASE%\bootpe_%PE_ARCH%.iso
goto END


:END
