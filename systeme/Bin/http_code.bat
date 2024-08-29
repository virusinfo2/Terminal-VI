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
::Zh4grVQjdCyDJGyX8VAjFDFRTQrPEG73FrASpbrHy++UqVkSRN4PaoDcyLWDLeEH40rqSaIoxHdTlsoAQS1xQgGyfRsxpGt+lG2LC8+Ipx/eSUeN4wU1A2AU
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
setlocal enabledelayedexpansion
set "goto=rien"
set "URL=%~1"
for /f "tokens=1" %%a in ('call "%curl%" -s --max-filesize 15K -o nul -w "%%{http_code}" "!url!"') do set "http_code=%%a"

if "%~2" == "Gestion" (
  if not "!http_code!" == "200" (
    echo [ !time! ] [!http_code!] [!URL!] 2>&1 | "%tee%" -a "%log%"
    call "%LECTEUR%\systeme\erreur\erreur14.vbs"
    set "goto=goto 1"
  )
)