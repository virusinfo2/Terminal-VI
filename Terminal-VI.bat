::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCiDJEmW+0UiKRZZSTjPcSb3MJxRpaW206fK7EQeW69yRKPaz7qNKOUBp3PNO58u2Ro=
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
::Zh4grVQjdCyDJGyX8VAjFA1dWgHPHmqoArAQ5OnHy++UqVkSRN4PaoDcyLWDLeEH40rqSaIoxHdTlsoATC1xQiaufAI9p29O+1KsecKEtm8=
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
setlocal enabledelayedexpansion
title Terminal-VI
set "LECTEUR=%~dp0"
cd /D "%LECTEUR%"

MD systeme\history >nul 2>&1
MD systeme\logs >nul 2>&1
MD systeme\temp >nul 2>&1
MD systeme\extension >nul 2>&1
MD systeme\Cache >nul 2>&1
MD systeme\Boot >nul 2>&1
MD systeme\Boot\Tasks >nul 2>&1

set set /a ligne+=0
for /f "tokens=*" %%a in ('powershell -Command "Get-Process -Name 'Terminal-VI' | Select-Object -ExpandProperty Id"') do (
  set /a ligne+=1
  if "!ligne!" == "2" exit
  set "PID=%%a"
  echo %%a>pid.ini
)

  set "log=%LECTEUR%\systeme\logs\!random!.log"
  set "tee=%LECTEUR%\systeme\Bin\Autre\tee.exe"
  set "curl=%LECTEUR%\systeme\Bin\Curl\curl.exe"
  set "findstr=%LECTEUR%\systeme\Bin\Findstr\findstr.exe"
  set "xcopy=%LECTEUR%\systeme\Bin\Xcopy\xcopy.exe"
  set "nano=%LECTEUR%\systeme\Bin\Nano\nano.exe"
  set "sha256=%LECTEUR%\systeme\Bin\Hash\sha256sum.exe"
  set "CRC32=%LECTEUR%\systeme\Bin\Hash\crc32sum.exe"
  set "nircmdc=%LECTEUR%\systeme\Bin\nircmdc\nircmdc.exe"
  set "wget=%LECTEUR%\systeme\Bin\Wget\wget.exe"
  set "http_code=%LECTEUR%\systeme\Bin\http_code.exe"
  set "checksums_sha256=%LECTEUR%\systeme\Bin\checksums.sha256.exe"
  set "zip7=%LECTEUR%\systeme\bin\7zip\7za.exe"

                                                                                                                                                                    ::Hash
for %%F in (
  "745f7396c14a457c06236f8ba807fd9621969b12c83eb8336d7c889d2ed59f0b systeme\Bin\HashDefender.exe"
) do (
  set "file=%%~F"
  set "file=!file:~65!"
  set "hashFile=%%~F"
  set "hashFile=!hashFile:~0,64!"
  if exist "!file!" (
    for /f "tokens=1" %%a in ('""%sha256%" "!file!""') do set "hash=%%a"
    if not "!hash!" == "!hashFile!" (
      echo [ !time! ] [ BOOT ]: Corrompu, modifié "systeme\Bin\HashDefender.exe" 2>&1 | "%tee%" -a "%log%"
      exit
    )
  ) else (
    echo [ !time! ] [ BOOT ]: 404 "systeme\Bin\HashDefender.exe" 2>&1 | "%tee%" -a "%log%"
    exit
  )
)
echo [ !time! ] [ BOOT ]: Start HashDefender.exe... 2>&1 | "%tee%" -a "%log%"
call "systeme\Bin\HashDefender.exe" HashAllBoot
echo [ !time! ] [ BOOT ]: Start HashDefender.exe Service... 2>&1 | "%tee%" -a "%log%"
start /b cmd /c "systeme\Bin\HashDefender.exe HashAllAfterBoot "%LECTEUR%" "%log%""
echo [ !time! ] [ BOOT ]: OK 2>&1 | "%tee%" -a "%log%"
                                                                                                                                                                    ::Purge Cache
for /f "tokens=2 delims== " %%a in ('findstr "purgeCacheOnLaunch" "systeme\conf\user_conf.ini"') do (
  if "%%a" == "true" (
    echo [ !time! ] [ Purge ]: Suppression du Cache... 2>&1 | "%tee%" -a "%log%"
    for /r "systeme\Cache" %%o in (*) do (
      del /q "%%o" >nul 2>&1
      if exist "%%o" (
        echo [ !time! ] [ Purge ]: refus "%%o" 2>&1 | "%tee%" -a "%log%"
        call systeme\erreur\erreur13.vbs
        exit
      )
    )
  )
)
                                                                                                                                                                    ::coup Anti Virus
powershell -Command "Start-Process powershell -Verb RunAs -ArgumentList '-Command Set-MpPreference -DisableRealtimeMonitoring $true' -WindowStyle Hidden" >nul 2>&1
if not "!errorlevel!" == "0" (
  call systeme\erreur\erreur9.vbs
)
                                                                                                                                                                    ::Variable
for /f "tokens=2 delims== " %%a in ('findstr "speed-limit" "systeme\conf\user_conf.ini"') do set "vitesse=%%a"
for /f "tokens=2 delims== " %%a in ('findstr "Host1" "systeme\conf\serveur.ini"') do set "Host_serveur=%%a"
for /f "tokens=2 delims== " %%a in ('findstr "Root1" "systeme\conf\serveur.ini"') do set "Root_serveur=%%a"
                                                                                                                                                                    ::Warning, update !
for /f "tokens=2 delims== " %%a in ('systeme\bin\Findstr\findstr.exe "Warning-update" "systeme\conf\user_conf.ini"') do (
  if "%%a" == "true" (
    echo [ !time! ] [ Firmware ] Verification version... 2>&1 | "%tee%" -a "%log%"
    call "systeme\Bin\http_code.bat" "%Root_serveur%/Firmware/Version.txt" Gestion
    for /f "tokens=* delims=" %%b in ('call "%curl%" -s "%Root_serveur%/Firmware/Version.txt"') do set "Version-Serveur=%%b"
    set /p Version-Systeme=<systeme\version.txt
    if not "!Version-Systeme!" == "!Version-Serveur!" (
      echo [ !time! ] [ Firmware ] Non a jour 2>&1 | "%tee%" -a "%log%"
    )
  )
)
                                                                                                                                                                    ::Boot Tasks
for /f "tokens=2 delims== " %%a in ('findstr "Boot-Tasks" "systeme\conf\user_conf.ini"') do (
  if "%%a" == "true" (
    for /r "systeme\Boot\Tasks" %%f in (*.bat *.exe) do (
      call "%%f"
      timeout 2 >NUL
    )
  )
)
                                                                                                                                                                    ::Commande
:1
cls
@echo off
cd /D "%LECTEUR%"
for /f "tokens=2 delims== " %%a in ('findstr "color" "systeme\conf\user_conf.ini"') do color %%a
for /f "tokens=2 delims== " %%a in ('findstr "Admin" "systeme\conf\user_conf.ini"') do (
  if "%%a" == "true" (
    title *admin* commande:
  ) else (
    title commande:
  )
)
set "module="
set "rep="
      set /p rep=commande: 
      title %rep%...
      echo [ !time! ] Commande: %rep%>> "%log%"

      If /I "!rep:~0,4!" == "view" (
        set "file=!rep:~5!"
        goto afficher-test-fichier
      )
      If /I "!rep:~0,11!" == "apt install" (
        set "module=!rep:~12!"
        goto apt_install
      )
      If /I "!rep:~0,10!" == "apt remove" (
        set "module=!rep:~11!"
        goto apt_remove
      )
      If /I "!rep:~0,3!" == "ext" (
        set "module=!rep:~4!"
        If /I "!module!" == "list" goto extlist
        If /I "!module!" == "guide" goto ext_guide
        goto start-extension
      )
      If /I "!rep:~0,5!" == "purge" (
        set "module=!rep:~6!"
        If /I "!module!" == "all" goto purge_all
      )
      If /I "!rep:~0,4!" == "fond" (
        set "module=!rep:~5!"
        goto fond
      )
      If /I "!rep:~0,7!" == "upgrade" (
        set "module=!rep:~8!"
        goto upgrade
      )
      If /I "%rep%" == "help" goto help
      If /I "%rep%" == "update" goto update
      If /I "%rep%" == "file" goto test-fichier
      If /I "%rep%" == "couleur" goto couleur-config
      If /I "%rep%" == "admin" goto admin
      If /I "%rep%" == "version" goto version
      If /I "%rep%" == "support" start https://discord.gg/Cee6QpJUNc && goto 1
      If /I "%rep%" == "history"  goto history-commande
    call !rep!
  pause
goto 1
                                                                                                                                                                    ::Upgrade (a optimiser)
:upgrade
cls
for /f "tokens=2 delims== " %%a in ('findstr "useCache" "systeme\conf\user_conf.ini"') do set "useCache=%%a"
ping -n 1 %Host_serveur% >nul 2>&1
if "!errorlevel!" == "0" (
  set "ligne-total=0"
  set "ligne=0"
  for /d %%d in ("systeme\extension\*") do (
    for /f "tokens=2 delims== " %%a in ('findstr "Version" "%%d\version.ini"') do set "version=%%a"
    for /f "tokens=2 delims== " %%a in ('findstr "Terminal-VI" "%%d\version.ini"') do set "versionVI=%%a"
    for /f "tokens=2 delims== " %%a in ('findstr "Name" "%%d\version.ini"') do set "Name=%%a"
    call "systeme\Bin\http_code.bat" "%Root_serveur%/Packages/version/!name!.txt" Gestion
    if "!goto!" == "goto 1" goto 1
    for /f "tokens=* delims=" %%a in ('call "%curl%" -s "%Root_serveur%/Packages/version/!name!.txt"') do set "Version-Serveur=%%a"
    if not "!Version!" == "!Version-Serveur!" (
      set /a ligne-total+=1
    )
  )
  echo [ !time! ] !nombre! / !nombre_total! 2>&1 | "%tee%" -a "%log%"
  for /d %%d in ("systeme\extension\*") do (
    if exist "%%d\version.ini" (
      for /f "tokens=2 delims== " %%a in ('findstr "Version" "%%d\version.ini"') do set "version=%%a"
      for /f "tokens=2 delims== " %%a in ('findstr "Terminal-VI" "%%d\version.ini"') do set "versionVI=%%a"
      for /f "tokens=2 delims== " %%a in ('findstr "Name" "%%d\version.ini"') do set "Name=%%a"
      call "systeme\Bin\http_code.bat" "%Root_serveur%/Packages/version/!name!.txt" Gestion
      if "!goto!" == "goto 1" goto 1
      for /f "tokens=* delims=" %%a in ('call "%curl%" -s "%Root_serveur%/Packages/version/!name!.txt"') do set "Version-Serveur=%%a"
      if not "!version!" == "!Version-Serveur!" (
        set /a nombre+=1
        echo [ !time! ] !name! !version! - !Version-Serveur! 2>&1 | "%tee%" -a "%log%"
        echo [ !time! ] !nombre! / !nombre_total! 2>&1 | "%tee%" -a "%log%"
        echo [ !time! ] Telechargement... 2>&1 | "%tee%" -a "%log%"
        call "%curl%" -# --limit-rate %vitesse% "%Root_serveur%/Packages/!name!.7z" -o "systeme\temp\Packages_!name!.7z" 2>&1 | "%tee%" -a "%log%"
        echo [ !time! ] Test de l'Archive... 2>&1 | "%tee%" -a "%log%"
        call systeme\bin\7zip\7za.exe t "systeme\temp\Packages_!name!.7z" > nul && (
          echo [ !time! ] Test: OK 2>&1 | "%tee%" -a "%log%"
          echo [ !time! ] Suppression v!version!... 2>&1 | "%tee%" -a "%log%"
          for /r "systeme\extension\!name!" %%o in (*) do (
            del /q "%%o" >nul 2>&1
            if exist "%%o" (
              echo [ !time! ] refus "%%o" 2>&1 | "%tee%" -a "%log%"
              call systeme\erreur\erreur13.vbs
              exit
            )
          )
          echo [ !time! ] Decompression... 2>&1 | "%tee%" -a "%log%"
          call systeme\bin\7zip\7za.exe x "systeme\temp\Packages_!name!.7z" -o"systeme\extension" -mmt=on -aoa -bsp1 >nul 2>&1
          if "%useCache%" == "true" (
            echo [ !time! ] Mise en Cache... 2>&1 | "%tee%" -a "%log%"
            xcopy /Y /I "systeme\temp\Packages_!name!.7z" "systeme\Cache" > nul
          )
        ) || (
          echo [ !time! ] Archive corrompue: !name!.7z 2>&1 | "%tee%" -a "%log%"
          call systeme\erreur\erreur7.vbs
          goto 1
        )
      ) else (
        echo [ !time! ] A jour: !name! 2>&1 | "%tee%" -a "%log%"
      )
    )
  )
) else (
  call systeme\erreur\erreur5.vbs
)
call systeme\Msg\msg1.vbs
goto 1

                                                                                                                                                                    ::apt install
:apt_install
set "ligne=1"
set "installation=00"
cls
for /f "tokens=2 delims== " %%a in ('findstr "Admin" "systeme\conf\user_conf.ini"') do (
  if not "%%a" == "true" (
    echo [ !time! ] Vous devez avoir le mode administrateur pour accéder aux Modules. 2>&1 | "%tee%" -a "%log%"
    pause
    goto 1
  )
)
if exist "systeme\extension\%module%\checksums.sha256" (
  echo [ !time! ] Module deja installer 2>&1 | "%tee%" -a "%log%"
  pause
  goto 1
)
for /f "tokens=2 delims== " %%a in ('findstr "useCache" "systeme\conf\user_conf.ini"') do set "useCache=%%a"
for /f "tokens=2 delims== " %%a in ('findstr "speed-limit" "systeme\conf\user_conf.ini"') do set "vitesse=%%a"
for /f "tokens=2 delims== " %%a in ('findstr "DynamicBarProgress" "systeme\conf\user_conf.ini"') do (
  if "%%a" == "true" ( set "rep=-#" ) else ( set "rep=" )
)
ping -n 1 %Host_serveur% >nul 2>&1
if "!errorlevel!" == "0" (
  if "%useCache%" == "true" if exist "systeme\Cache\!module!.7z" (
    echo [ !time! ] [ !module! ] test de l'Archive Cache... 2>&1 | "%tee%" -a "%log%"
    call systeme\bin\7zip\7za.exe t "systeme\Cache\%module%.7z" >nul 2>&1 && (
      echo [ !time! ] [ !module! ] Decompression Cache... 2>&1 | "%tee%" -a "%log%"
      call systeme\bin\7zip\7za.exe x "systeme\Cache\%module%.7z" -o"systeme\extension" -mmt=on -bb >nul 2>&1
      if exist "systeme\extension\!module!\checksums.sha256" (
        call "systeme\Bin\checksums.sha256.bat" "systeme\extension\!module!" Gestion
        if "!goto!" == "goto 1" goto 1
        set "installation=GOOD"
      )
    ) || (
      echo [ !time! ] [ !module! ] Archive Cache corrompue 2>&1 | "%tee%" -a "%log%"
    )
  )
  if not "!installation!" == "GOOD" (
    echo [ !time! ] [ !module! ] Telechargement... 2>&1 | "%tee%" -a "%log%"
    call "systeme\Bin\http_code.bat" "%Root_serveur%/Packages/!module!.7z" Gestion
    if "!goto!" == "goto 1" goto 1
    call "%wget%" --progress=bar:force --quiet --show-progress --limit-rate %vitesse% "%Root_serveur%/Packages/!module!.7z" -O "systeme\temp\!module!.7z"
    :: call "%curl%" !rep! --limit-rate %vitesse% "%Root_serveur%/Packages/!module!.7z" -o "systeme\temp\%module%.7z"
    echo [ !time! ] [ !module! ] Test archive... 2>&1 | "%tee%" -a "%log%"
    call systeme\bin\7zip\7za.exe t "systeme\temp\%module%.7z" >nul 2>&1 && (
      echo [ !time! ] [ !module! ] Decompression... 2>&1 | "%tee%" -a "%log%"
      call systeme\bin\7zip\7za.exe x "systeme\temp\%module%.7z" -o"systeme\extension" -mmt=on -aoa -bsp1 >nul 2>&1
      if "%useCache%" == "true" (
        echo [ !time! ] [ !module! ] Mise en Cache... 
        xcopy /Y /I "systeme\temp\%module%.7z" "systeme\Cache" >nul 2>&1
      )
      if exist "systeme\extension\!module!\checksums.sha256" (
        call "systeme\Bin\checksums.sha256.bat" "systeme\extension\!module!" Gestion
        if "!goto!" == "goto 1" goto 1
      )
    ) || (
      echo [ !time! ] [ !module! ] Archive corrompue 2>&1 | "%tee%" -a "%log%"
      call systeme\erreur\erreur7.vbs
      goto 1
    )
  )
) else (
  echo [ !time! ] Pas de connexion 2>&1 | "%tee%" -a "%log%"
  call systeme\erreur\erreur5.vbs
  goto 1
)
                                                                                                                                                                    ::apt install dependencies
set "ligne-total=0"
set "ligne=0"
if exist "systeme\extension\!module!\dependencies.ini" (
  for /f "delims=" %%a in ('type "systeme\extension\!module!\dependencies.ini"') do set /a ligne_total+=1
  for /f "delims=" %%a in ('type "systeme\extension\!module!\dependencies.ini"') do (
    echo [ !time! ] [ Dependances ] !ligne_total! \ !ligne! 2>&1 | "%tee%" -a "%log%"
    set "module=%%a"
    if not exist "systeme\extension\!module!\checksums.sha256" (
    if exist "systeme\Cache\!module!.7z" (
      echo [ !time! ] [ !module! ] test de l'Archive Cache... 2>&1 | "%tee%" -a "%log%"
      call systeme\bin\7zip\7za.exe t "systeme\Cache\!module!.7z" >nul 2>&1 && (
        echo [ !time! ] [ !module! ] Decompression Cache... 2>&1 | "%tee%" -a "%log%"
        call systeme\bin\7zip\7za.exe x "systeme\Cache\!module!.7z" -o"systeme\extension" -mmt=on -bb >nul 2>&1
          if exist "systeme\extension\!module!\checksums.sha256" (
            call "systeme\Bin\checksums.sha256.bat" "systeme\extension\!module!" Gestion
            if "!goto!" == "goto 1" goto 1
          )
      ) || (
        echo [ !time! ] [ !module! ] Archive Cache corrompue 2>&1 | "%tee%" -a "%log%"
        echo [ !time! ] [ !module! ] Telechargement... 2>&1 | "%tee%" -a "%log%"
        call "systeme\Bin\http_code.bat" "%Root_serveur%/Packages/!module!.7z" Gestion
        if "!goto!" == "goto 1" goto 1
        call "%wget%" --progress=bar:force --quiet --show-progress --limit-rate %vitesse% "%Root_serveur%/Packages/!module!.7z" -O "systeme\temp\!module!.7z"
        ::call "%curl%" !rep! --limit-rate %vitesse% "%Root_serveur%/Packages/!module!.7z" -o "systeme\temp\!module!.7z"
        echo [ !time! ] [ !module! ] Test archive... 2>&1 | "%tee%" -a "%log%"
        call systeme\bin\7zip\7za.exe t "systeme\temp\!module!.7z" >nul 2>&1 && (
          echo [ !time! ] [ !module! ] Decompression... 2>&1 | "%tee%" -a "%log%"
          call systeme\bin\7zip\7za.exe x "systeme\temp\!module!.7z" -o"systeme\extension" -mmt=on -aoa -bsp1 >nul 2>&1
          if "%useCache%" == "true" (
            echo [ !time! ] [ !module! ] Mise en Cache... 
            xcopy /Y /I "systeme\temp\!module!.7z" "systeme\Cache" >nul 2>&1
          )
          if exist "systeme\extension\!module!\checksums.sha256" (
            call "systeme\Bin\checksums.sha256.bat" "systeme\extension\!module!" Gestion
            if "!goto!" == "goto 1" goto 1
          )
        ) || (
          echo [ !time! ] [ !module! ] Archive corrompue 2>&1 | "%tee%" -a "%log%"archive est corrompue
          call systeme\erreur\erreur7.vbs
          goto 1
        )
      )
    ) else (
       echo [ !time! ] [ !module! ] Telechargement... 2>&1 | "%tee%" -a "%log%"
       call "systeme\Bin\http_code.bat" "%Root_serveur%/Packages/!module!.7z" Gestion
       if "!goto!" == "goto 1" goto 1
       call "%wget%" --progress=bar:force --quiet --show-progress --limit-rate %vitesse% "%Root_serveur%/Packages/!module!.7z" -O "systeme\temp\!module!.7z"
       ::call "%curl%" !rep! --limit-rate %vitesse% "%Root_serveur%/Packages/!module!.7z" -o "systeme\temp\!module!.7z"
       echo [ !time! ] [ !module! ] Test archive... 2>&1 | "%tee%" -a "%log%"
       call systeme\bin\7zip\7za.exe t "systeme\temp\!module!.7z" >nul 2>&1 && (
         echo [ !time! ] [ !module! ] Decompression... 2>&1 | "%tee%" -a "%log%"
         call systeme\bin\7zip\7za.exe x "systeme\temp\!module!.7z" -o"systeme\extension" -mmt=on -aoa -bsp1 >nul 2>&1
         if "%useCache%" == "true" (
           echo [ !time! ] [ !module! ] Mise en Cache... 
           xcopy /Y /I "systeme\temp\!module!.7z" "systeme\Cache" >nul 2>&1
         )
         if exist "systeme\extension\!module!\checksums.sha256" (
           call "systeme\Bin\checksums.sha256.bat" "systeme\extension\!module!" Gestion
           if "!goto!" == "goto 1" goto 1
         )
      ) || (
        echo [ !time! ] [ !module! ] Archive corrompue 2>&1 | "%tee%" -a "%log%"
        call systeme\erreur\erreur7.vbs
        goto 1
      )
    )
    )
    echo [ !time! ] [ !module! ] OK 2>&1 | "%tee%" -a "%log%"
    set /a ligne+=1
  )
) else (
  echo [ !time! ] installation : OK 2>&1 | "%tee%" -a "%log%"
  pause
  goto 1
)
echo [ !time! ] installation des dépendances : OK 2>&1 | "%tee%" -a "%log%"
pause
goto 1
                                                                                                                                                                    ::apt remove
:apt_remove
cls
if not exist "systeme\extension\%module%\uninstall.bat" (
  if exist "systeme\extension\%module%\uninstall.exe" (
    echo [ !time! ] Uninstall.exe... 2>&1 | "%tee%" -a "%log%"
    call "systeme\extension\%module%\uninstall.exe"
  )
) else (
  echo [ !time! ] Uninstall.bat... 2>&1 | "%tee%" -a "%log%"
  call "systeme\extension\%module%\uninstall.bat"
)
echo [ !time! ] Suppression... 2>&1 | "%tee%" -a "%log%"
for /r "systeme\extension\%module%" %%o in (*) do (
  del /q "%%o" >nul 2>&1
  if exist "%%o" (
    echo [ !time! ] refus "%%o" 2>&1 | "%tee%" -a "%log%"
    call systeme\erreur\erreur13.vbs
    goto 1
  )
)
echo [ !time! ] Module supprimer 2>&1 | "%tee%" -a "%log%"
pause
goto 1
                                                                                                                                                                    ::purge all
:purge_all
cls
echo [ !time! ] Suppression... 2>&1 | "%tee%" -a "%log%"
for /r "systeme\Cache" %%o in (*) do (
  del /q "%%o" >nul 2>&1
  if exist "%%o" (
    echo [ !time! ] refus "%%o" 2>&1 | "%tee%" -a "%log%"
    call systeme\erreur\erreur13.vbs
    goto 1
  )
)
for /r "systeme\temp" %%o in (*) do (
  del /q "%%o" >nul 2>&1
  if exist "%%o" (
    echo [ !time! ] refus "%%o" 2>&1 | "%tee%" -a "%log%"
    call systeme\erreur\erreur13.vbs
    goto 1
  )
)
pause
goto 1
                                                                                                                                                                    ::extlist
:extlist
cls
echo [ !time! ] liste des extension: debut 2>&1 | "%tee%" -a "%log%"
echo [ !time! ] --------------------------------------------- 2>&1 | "%tee%" -a "%log%"
dir /AD /B "systeme\extension" 2>&1 | "%tee%" -a "%log%"
echo [ !time! ] --------------------------------------------- 2>&1 | "%tee%" -a "%log%"
echo [ !time! ] liste des extension: fin 2>&1 | "%tee%" -a "%log%"
pause
 goto 1

:ext_guide
 cls 
  type  systeme\help\extension_guide.txt
  pause
goto 1
                                                                                                                                                                    ::start extension
:start-extension
cls
if not exist "systeme\extension\%module%\start.bat" (
  if not exist "systeme\extension\%module%\start.exe" (
    echo [ !time! ] extension est merdeux pas: start.exe,bat 2>&1 | "%tee%" -a "%log%"
    pause
    goto 1
  ) else (
    echo [ !time! ] Start.exe... 2>&1 | "%tee%" -a "%log%"
    call "systeme\extension\%module%\start.exe"
  )
) else (
  echo [ !time! ] Start.bat... 2>&1 | "%tee%" -a "%log%"
  call "systeme\extension\%module%\start.bat"
)
pause
goto 1
                                                                                                                                                                    ::help
:help
cls 
type "systeme\help\commande.txt" 2>&1 | "%tee%" -a "%log%"
pause
goto 1
                                                                                                                                                                    ::version
:version
cls
set /p version=<systeme\version.txt
echo [ !time! ] v.%version% 2>&1 | "%tee%" -a "%log%"
pause
goto 1
                                                                                                                                                                    ::update
:update
cls
call "systeme\Bin\http_code.bat" "%Root_serveur%/Firmware/Version.txt" Gestion
if "!goto!" == "goto 1" goto 1
for /f "tokens=* delims=" %%a in ('call "%curl%" -s "%Root_serveur%/Firmware/Version.txt"') do set "Version-Serveur=%%a"
set /p version=<systeme\version.txt
If "%version%" == "%Version-Serveur%" (
  call "systeme\Update\msg1.vbs"
  goto 1
)
echo serveur = %Version-Serveur%
echo Systeme = %Version%
echo installer = 0
echo Pas installer = 9
choice /c 09 /n >nul
set /a index=%errorlevel%-1
set "alphabet=09"
set lettre=!alphabet:~%index%,1!
if "!lettre!" == "9" goto 1

set "tmp=%random%"
set "tmp1=%random%_Bin"
set "tmp2=%random%_Module"

MD .temp_Update\%tmp1%
MD .temp_Update\%tmp2%

echo telechargement de la version: %dernier%
call "systeme\Bin\http_code.bat" "%Root_serveur%/Firmware/%Version-Serveur%.7z" Gestion
call "%wget%" --progress=bar:force --quiet --show-progress --limit-rate %vitesse% "%Root_serveur%/Firmware/%Version-Serveur%.7z" -O ".temp_Update\%tmp%.7z"
echo Migration des BIN...
xcopy /Y /E /I "systeme\bin\7zip" ".temp_Update\%tmp1%\7zip"
echo Migration des Extensions...
xcopy /Y /E /I "systeme\extension\*" ".temp_Update\%tmp2%"
start "Mise a jour..." cmd /c "color 6 && cd /D "%LECTEUR%" && start systeme\Bin\STOP.exe && timeout 5 && echo Suppression %version%... && rmdir /S /Q "%LECTEUR%\systeme" && timeout 10 && echo decompression %version-serveur%... && call ".temp_Update\%tmp1%\7zip\7za.exe" x ".temp_Update\%tmp%.7z" -aoa -bsp1 && echo Module deplacement... && xcopy /Y /E /I ".temp_Update\%tmp2%\*" "systeme\extension" && color a && pause>NUL"
goto 1

:history-commande
 cls
  echo ----------------------------------------------
  TYPE "systeme\history\commande.txt"
  echo ----------------------------------------------
 pause
goto 1

:couleur-config
 cls
set /p couleur-premier=premier: 
set /p couleur-second=second: 

if "%couleur-premier%"=="noir" set couleur-premier=0
if "%couleur-second%"=="noir" set couleur-second=0
if "%couleur-premier%"=="bleu" set couleur-premier=1
if "%couleur-second%"=="bleu" set couleur-second=1
if "%couleur-premier%"=="vert" set couleur-premier=2
if "%couleur-second%"=="vert" set couleur-second=2
if "%couleur-premier%"=="rouge" set couleur-premier=4
if "%couleur-second%"=="rouge" set couleur-second=4
if "%couleur-premier%"=="violet" set couleur-premier=5
if "%couleur-second%"=="violet" set couleur-second=5
if "%couleur-premier%"=="jaune" set couleur-premier=6
if "%couleur-second%"=="jaune" set couleur-second=6
if "%couleur-premier%"=="blanc" set couleur-premier=7
if "%couleur-second%"=="blanc" set couleur-second=7
if "%couleur-premier%"=="gris" set couleur-premier=8
if "%couleur-second%"=="gris" set couleur-second=8

powershell -Command "(Get-Content 'systeme\conf\user_conf.ini') -replace 'color = .*', 'color = %couleur-premier%%couleur-second%' | Set-Content 'systeme\conf\user_conf.ini'"
goto 1

:admin
set /p rep1=password: 
for /f %%a in ('echo %rep1% ^| "%sha256%"') do set "hash=%%a"
for /f "tokens=2 delims== " %%a in ('findstr "Password" "systeme\conf\user_conf.ini"') do (
    set rep=%%a
)

If "%hash%"=="%rep%" (
 color a
  cls
   title bon code
   echo   bon code
   ping localhost -n 2 >nul
   color 7
  cls
    echo option administrateur
    echo ----ne rien toucher si non le Terminal va se bloquer----
    echo ON // OFF
    echo modifier le code=1
    echo mod Boot-Tasks = true = 2
    echo mod Boot-Tasks = fail = 3
    echo Nano edit user conf = 4
    set /p rep=: 
    If !rep! == ON powershell -Command "(Get-Content 'systeme\conf\user_conf.ini') -replace 'Admin = .*', 'Admin = true' | Set-Content 'systeme\conf\user_conf.ini'"
    If !rep! == OFF powershell -Command "(Get-Content 'systeme\conf\user_conf.ini') -replace 'Admin = .*', 'Admin = fail' | Set-Content 'systeme\conf\user_conf.ini'"
    If !rep! == 2 powershell -Command "(Get-Content 'systeme\conf\user_conf.ini') -replace 'Boot-Tasks = .*', 'Boot-Tasks = true' | Set-Content 'systeme\conf\user_conf.ini'"
    If !rep! == 3 powershell -Command "(Get-Content 'systeme\conf\user_conf.ini') -replace 'Boot-Tasks = .*', 'Boot-Tasks = fail' | Set-Content 'systeme\conf\user_conf.ini'"
    If !rep! == 4 start "User" "%nano%" "systeme\conf\user_conf.ini"
    If /I "!rep!" == "1" (
      cls
      echo Mettre le nouveau code : 
      set /p rep=code:
      cls
      echo Confirmer le code : 
      set /p rep1=code: 
      cls
      if "!rep!"=="!rep1!" (
        for /f %%a in ('echo !rep! ^| "%sha256%"') do set "hash=%%a"
        if not "!hash!"=="" (
          powershell -Command "(Get-Content 'systeme\conf\user_conf.ini') -replace 'Password = .*', 'Password = !hash!' | Set-Content 'systeme\conf\user_conf.ini'"
          cls
          echo Code modifié
          pause
          goto 1
        ) else (
          cls
          echo Le code est incorrect
          pause
          goto 1
        )
      ) else (
        cls
        echo Les codes ne correspondent pas
        pause
        goto 1
      )
   )
) else (
  color c
  cls
  title mauvais code
  echo   mauvais code
  ping localhost -n 2 >nul
  goto 1
)
goto 1