@ECHO OFF
SET oldPath=%PATH%

git.exe 2> NUL
if %ERRORLEVEL%==9009 GOTO :trydefaultpath
GOTO :EOF

:trydefaultpath
path=C:\Program Files (x86)\Git\cmd;%PATH%
git.exe 2> NUL
if %ERRORLEVEL%==9009 GOTO :showerror
GOTO :EOF

:showerror
path=%oldPath%
ECHO Git is not in your path and could not be found in C:\Program Files (x86)\Git\bin 
set /p install=" Do you want to install Git through Chocolatey [y/n]? " %=%
if %install%==y (
	GOTO :installgit
) else (
	GOTO :cantcontinue
)

:cantcontinue
ECHO Can't complete the build without Git being in the path. Please add it to be able to continue.
GOTO :EOF

:installgit
ECHO Installing Chocolatey first
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
ECHO Installing Git through Chocolatey
choco install git
path=C:\Program Files (x86)\Git\cmd;%path%
