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
::Zh4grVQjdCyDJGyX8VAjFDFRTQrPEG73FrASpbrHy++UqVkSRN4PaoDcyLWDLeEH40rqSaIoxHdTlsoAQS1xQgGyfRsxpGt+lG2LC8SUtgzqWV2E9QUjE2Qm0jWeiTM+AA==
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
setlocal enabledelayedexpansion
echo [ !time! ] [ Hash ] Test des Hash 2>&1 | "%tee%" -a "%log%"

set "goto=rien"
if exist "%~1" (
  set "Dossier=%~1"
)

if not "%~2" == "" (
  if "%~2" == "Gestion" (
    set "Fichier_sha256=checksums.sha256"
  ) else (
    set "Fichier_sha256=%~2"
  )
) else (
  set "Fichier_sha256=checksums.sha256"
)

set "erreur=0"
CD /D "!Dossier!"


for /f "delims=" %%i in ('type "%Fichier_sha256%"') do (
  set "file=%%~i"
  set "file=!file:~65!"
  set "hashFile=%%~i"
  set "hashFile=!hashFile:~0,64!"
  echo [ !time! ] [ Hash ] !file!... 2>&1 | "%tee%" -a "%log%"
  if exist "!file!" (
    for /f "tokens=1" %%a in ('""%sha256%" "!file!""') do set "hash=%%a"
    if "!hash!" == "!hashFile!" (
      echo [ !time! ] [ Hash ] !file! : OK 2>&1 | "%tee%" -a "%log%"
    ) else (
      echo [ !time! ] [ Hash ] !file! : Erreur Hash 2>&1 | "%tee%" -a "%log%"
      set "erreur=1"
    )
  ) else (
    echo [ !time! ] [ Hash ] !file! : 404 2>&1 | "%tee%" -a "%log%"
    set "erreur=1"
  )
)
if "!erreur!" == "0" (
  echo [ !time! ] [ Hash ] OK 2>&1 | "%tee%" -a "%log%"
  set "goto=OK"
) else (
  echo [ !time! ] [ Hash ] NON 2>&1 | "%tee%" -a "%log%"
  set "goto=goto 1"
)
echo %goto%>"%temp%\result_checksums.sha256.txt"
cd /D "%LECTEUR%"