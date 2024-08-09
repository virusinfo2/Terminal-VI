::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSjk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFDFRTQrPEG73FrASpbrHy++UqVkSRN4PaoDcyLWDLeEH40rqSaIoxHdTlsoAQS1xQgGyfRsxpGt+lG2LC++doAfFT06M6E81CStxn2aw
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
setlocal enabledelayedexpansion
if "%~1" == "HashAllBoot" goto HashAllBoot
if "%~1" == "HashAllAfterBoot" goto HashAllAfterBoot
exit

:HashAllAfterBoot
set "LECTEUR=%~2"
cd /D "%LECTEUR%"
set "sha256=%LECTEUR%\systeme\Bin\Hash\sha256sum.exe"
for /l %%n in (0,0,1) do (
set ligne=0
  for %%F in (
    "583f67ca7b7301f5524fda8405afcb1d38b481556799d80a633978024577ebab systeme\Bin\7zip\7za.dll"
    "199c64ad672453e98d86ad2c4ea88212eafd6f7c4070dfcb7609ab7a9bd5df11 systeme\Bin\7zip\7za.exe"
    "7454cd03cfa197b979cb62360f69143a48a8be86227f06538c546a70a14cde2c systeme\Bin\7zip\7zxa.dll"
  ) do (
    set "file=%%~F"
    set "file=!file:~65!"
    set "hashFile=%%~F"
    set "hashFile=!hashFile:~0,64!"
    if exist "!file!" (
      for /f "tokens=1" %%a in ('""%sha256%" "!file!""') do set "hash=%%a"
      if not "!hash!" == "!hashFile!" (
        cls
        call "systeme\erreur\erreur11.vbs"
        start systeme\Bin\STOP.exe
        taskkill /F /IM cmd.exe
        goto fini
      )
    ) else (
      cls
      call "systeme\erreur\erreur10.vbs"
      start systeme\Bin\STOP.exe
      taskkill /F /IM cmd.exe
      goto fini
    )
  )
)
exit
goto fini

:HashAllBoot
set ligne=1
for %%F in (
  "583f67ca7b7301f5524fda8405afcb1d38b481556799d80a633978024577ebab systeme\Bin\7zip\7za.dll"
  "199c64ad672453e98d86ad2c4ea88212eafd6f7c4070dfcb7609ab7a9bd5df11 systeme\Bin\7zip\7za.exe"
  "7454cd03cfa197b979cb62360f69143a48a8be86227f06538c546a70a14cde2c systeme\Bin\7zip\7zxa.dll"
) do (
  set /a ligne+=1
  set "file=%%~F"
  set "file=!file:~65!"
  set "hashFile=%%~F"
  set "hashFile=!hashFile:~0,64!"
  echo [ !time! ] [ Hash ] !file!... 2>&1 | "%tee%" -a "%log%"
  if exist "!file!" (
    for /f "tokens=1" %%a in ('""%sha256%" "!file!""') do set "hash=%%a"
    if "!hash!" == "!hashFile!" (
    echo [ !time! ] [ Hash ] !file! : OK 2>&1 | "%tee%" -a "%log%"
    ) else (
      echo [ !time! ] [ Hash ] !file! : corrompu 2>&1 | "%tee%" -a "%log%"
      call "systeme\erreur\erreur11.vbs"
    )
  ) else (
    echo [ !time! ] [ Hash ] !file! : 404 2>&1 | "%tee%" -a "%log%"
    call "systeme\erreur\erreur10.vbs"
    exit
  )
)


:fini