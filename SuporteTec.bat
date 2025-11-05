@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion
color 0A
mode con cols=100 lines=40
title MENU- Ferramenta de Suporte Diagonal

for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value 2^>nul') do set datetime=%%I
set LOGFILE=%TEMP%\error_killer_%datetime:~0,8%.txt

:: Configuração da pasta de programas
set "PASTA_PROGRAMAS=C:\Programas"
set "PROGRAMAS_INSTALADOS=0"
set "PROGRAMAS_PULADOS=0"

:menu
cls
echo.
echo  ================================================================
echo.
echo                       D I A G O N A L
echo.
echo  ================================================================
echo.
echo  [1]  INSTALAR PROGRAMAS
echo  [2]  REDES
echo  [3]  DISPOSITIVOS
echo  [4]  GERENCIADOR DE TAREFAS
echo.
echo  [S]  CONFIGURACOES DO SISTEMA
echo  [0]  SAIR
echo  ================================================================
echo.
set /p opcao= Comando: 

if /i "%opcao%"=="1" goto programas
if /i "%opcao%"=="2" goto redes
if /i "%opcao%"=="3" goto dispositivos
if /i "%opcao%"=="4" goto gerenciador
if /i "%opcao%"=="S" goto configuracoes
if /i "%opcao%"=="0" goto fim

echo.
echo  [ERRO] Opcao invalida!
timeout /t 2 >nul
goto menu

:programas
cls
echo.
echo  ================================================================
echo                 INSTALACAO AUTOMATICA DE PROGRAMAS
echo  ================================================================
echo.
echo  Pasta de instaladores: %PASTA_PROGRAMAS%
echo.

:: Verifica se a pasta existe
if not exist "%PASTA_PROGRAMAS%" (
    echo  [AVISO] Pasta de programas nao encontrada!
    echo  Crie a pasta: %PASTA_PROGRAMAS%
    echo  e adicione os instaladores.
    echo.
    echo  [1] Criar pasta agora
    echo  [0] Voltar
    echo.
    set /p criar_pasta= Escolha: 
    if "!criar_pasta!"=="1" (
        mkdir "%PASTA_PROGRAMAS%" >nul 2>&1
        echo  [+] Pasta criada: %PASTA_PROGRAMAS%
        echo  [*] Adicione os instaladores e execute novamente.
        pause
        start "" "%PASTA_PROGRAMAS%"
    )
    goto menu
)

echo  [1]  Parallels Desktop
echo  [2]  Google Chrome
echo  [3]  GoTo Meeting
echo  [4]  7-Zip
echo  [5]  AnyDesk
echo  [6]  NDD Print Agent
echo  [7]  Microsoft Teams
echo  [8]  Java Runtime
echo  [9]  FortiClient VPN
echo  [10] Foxit PDF Reader
echo  [11] Microsoft Office 365
echo.
echo  [A]  INSTALAR TODOS OS PROGRAMAS
echo  [V]  VERIFICAR INSTALADORES
echo  [0]  VOLTAR
echo  ================================================================
echo.
set /p escolha= Selecione os programas: 

if /i "%escolha%"=="A" goto instalar_todos
if /i "%escolha%"=="V" goto verificar_instaladores
if "%escolha%"=="1" goto instalar_parallels
if "%escolha%"=="2" goto instalar_chrome
if "%escolha%"=="3" goto instalar_goto
if "%escolha%"=="4" goto instalar_7zip
if "%escolha%"=="5" goto instalar_anydesk
if "%escolha%"=="6" goto instalar_ndd
if "%escolha%"=="7" goto instalar_teams
if "%escolha%"=="8" goto instalar_java
if "%escolha%"=="9" goto instalar_forticlient
if "%escolha%"=="10" goto instalar_foxit
if "%escolha%"=="11" goto instalar_office
if "%escolha%"=="0" goto menu

echo.
echo  [ERRO] Opcao invalida!
timeout /t 2 >nul
goto programas

:verificar_instaladores
cls
echo.
echo  ================================================================
echo               VERIFICACAO DE INSTALADORES NA PASTA
echo  ================================================================
echo.
echo  Pasta: %PASTA_PROGRAMAS%
echo.

set "ENCONTRADOS=0"
echo  Procurando instaladores...
echo.

:: Procura por arquivos comuns de instalacao - MODIFICADO PARA PARALLELS
if exist "%PASTA_PROGRAMAS%\2xclient-x64.msi" (
    echo  [✓] Parallels: 2xclient-x64.msi
    set "PARALLELS_FILE=%PASTA_PROGRAMAS%\2xclient-x64.msi"
    set /a ENCONTRADOS+=1
) else (
    for %%F in ("%PASTA_PROGRAMAS%\*parallels*") do if exist "%%F" (
        echo  [✓] Parallels: %%~nxF
        set "PARALLELS_FILE=%%F"
        set /a ENCONTRADOS+=1
    )
)
for %%F in ("%PASTA_PROGRAMAS%\*chrome*") do if exist "%%F" (
    echo  [✓] Chrome: %%~nxF
    set "CHROME_FILE=%%F"
    set /a ENCONTRADOS+=1
)
for %%F in ("%PASTA_PROGRAMAS%\*goto*") do if exist "%%F" (
    echo  [✓] GoTo: %%~nxF
    set "GOTO_FILE=%%F"
    set /a ENCONTRADOS+=1
)
for %%F in ("%PASTA_PROGRAMAS%\*7z*") do if exist "%%F" (
    echo  [✓] 7-Zip: %%~nxF
    set "7ZIP_FILE=%%F"
    set /a ENCONTRADOS+=1
)
for %%F in ("%PASTA_PROGRAMAS%\*anydesk*") do if exist "%%F" (
    echo  [✓] AnyDesk: %%~nxF
    set "ANYDESK_FILE=%%F"
    set /a ENCONTRADOS+=1
)
for %%F in ("%PASTA_PROGRAMAS%\*ndd*") do if exist "%%F" (
    echo  [✓] NDD: %%~nxF
    set "NDD_FILE=%%F"
    set /a ENCONTRADOS+=1
)
for %%F in ("%PASTA_PROGRAMAS%\*teams*") do if exist "%%F" (
    echo  [✓] Teams: %%~nxF
    set "TEAMS_FILE=%%F"
    set /a ENCONTRADOS+=1
)
for %%F in ("%PASTA_PROGRAMAS%\*java*") do if exist "%%F" (
    echo  [✓] Java: %%~nxF
    set "JAVA_FILE=%%F"
    set /a ENCONTRADOS+=1
)
for %%F in ("%PASTA_PROGRAMAS%\*forti*") do if exist "%%F" (
    echo  [✓] FortiClient: %%~nxF
    set "FORTI_FILE=%%F"
    set /a ENCONTRADOS+=1
)
for %%F in ("%PASTA_PROGRAMAS%\*foxit*") do if exist "%%F" (
    echo  [✓] Foxit: %%~nxF
    set "FOXIT_FILE=%%F"
    set /a ENCONTRADOS+=1
)
for %%F in ("%PASTA_PROGRAMAS%\*office*") do if exist "%%F" (
    echo  [✓] Office: %%~nxF
    set "OFFICE_FILE=%%F"
    set /a ENCONTRADOS+=1
)

echo.
echo  ================================================================
echo  Total de instaladores encontrados: !ENCONTRADOS! / 11
echo  ================================================================
echo.
if !ENCONTRADOS! equ 0 (
    echo  [AVISO] Nenhum instalador encontrado!
    echo  Coloque os arquivos na pasta: %PASTA_PROGRAMAS%
)
echo.
pause
goto programas

:instalar_todos
cls
echo.
echo  ================================================================
echo          INSTALANDO TODOS OS PROGRAMAS AUTOMATICAMENTE
echo  ================================================================
echo.
echo  Pasta de instaladores: %PASTA_PROGRAMAS%
echo.
set "PROGRAMAS_INSTALADOS=0"
set "PROGRAMAS_PULADOS=0"

echo  [*] Iniciando instalacao completa...
echo.
call :instalar_parallels
call :instalar_chrome
call :instalar_goto
call :instalar_7zip
call :instalar_anydesk
call :instalar_ndd
call :instalar_teams
call :instalar_java
call :instalar_forticlient
call :instalar_foxit
call :instalar_office

echo.
echo  ================================================================
echo                    RESUMO DA INSTALACAO
echo  ================================================================
echo  Programas instalados: !PROGRAMAS_INSTALADOS!
echo  Programas pulados: !PROGRAMAS_PULADOS!
echo  Total processado: 11
echo  ================================================================
echo.
pause
goto programas

:instalar_parallels
echo [1/11] Verificando Parallels Desktop...
reg query "HKLM\SOFTWARE\Parallels" >nul 2>&1
if %errorlevel% equ 0 (
    echo     [!] Parallels ja esta instalado
    set /a PROGRAMAS_PULADOS+=1
    goto :eof
)
if not defined PARALLELS_FILE (
    :: PRIMEIRO BUSCA PELO NOME ESPECÍFICO, DEPOIS POR PARALLELS
    if exist "%PASTA_PROGRAMAS%\2xclient-x64.msi" (
        set "PARALLELS_FILE=%PASTA_PROGRAMAS%\2xclient-x64.msi"
    ) else (
        for %%F in ("%PASTA_PROGRAMAS%\*parallels*") do if exist "%%F" set "PARALLELS_FILE=%%F"
    )
)
if not defined PARALLELS_FILE (
    echo     [X] Instalador do Parallels nao encontrado
    goto :eof
)
echo     [*] Instalando Parallels Desktop: !PARALLELS_FILE!
start "" /wait "!PARALLELS_FILE!" /quiet /norestart
echo     [+] Parallels Desktop instalado com sucesso
set /a PROGRAMAS_INSTALADOS+=1
goto :eof

:instalar_chrome
echo [2/11] Verificando Google Chrome...
reg query "HKLM\SOFTWARE\Google\Chrome" >nul 2>&1
if %errorlevel% equ 0 (
    echo     [!] Chrome ja esta instalado
    set /a PROGRAMAS_PULADOS+=1
    goto :eof
)
if not defined CHROME_FILE (
    for %%F in ("%PASTA_PROGRAMAS%\*chrome*") do if exist "%%F" set "CHROME_FILE=%%F"
)
if not defined CHROME_FILE (
    echo     [X] Instalador do Chrome nao encontrado
    goto :eof
)
echo     [*] Instalando Google Chrome: !CHROME_FILE!
start "" /wait "!CHROME_FILE!" /silent /install
echo     [+] Google Chrome instalado com sucesso
set /a PROGRAMAS_INSTALADOS+=1
goto :eof

:instalar_goto
echo [3/11] Verificando GoTo Meeting...
where gotomeeting >nul 2>&1
if %errorlevel% equ 0 (
    echo     [!] GoTo Meeting ja esta instalado
    set /a PROGRAMAS_PULADOS+=1
    goto :eof
)
if not defined GOTO_FILE (
    for %%F in ("%PASTA_PROGRAMAS%\*goto*") do if exist "%%F" set "GOTO_FILE=%%F"
)
if not defined GOTO_FILE (
    echo     [X] Instalador do GoTo nao encontrado
    goto :eof
)
echo     [*] Instalando GoTo Meeting: !GOTO_FILE!
start "" /wait "!GOTO_FILE!" /S
echo     [+] GoTo Meeting instalado com sucesso
set /a PROGRAMAS_INSTALADOS+=1
goto :eof

:instalar_7zip
echo [4/11] Verificando 7-Zip...
where 7z >nul 2>&1
if %errorlevel% equ 0 (
    echo     [!] 7-Zip ja esta instalado
    set /a PROGRAMAS_PULADOS+=1
    goto :eof
)
if not defined 7ZIP_FILE (
    for %%F in ("%PASTA_PROGRAMAS%\*7z*") do if exist "%%F" set "7ZIP_FILE=%%F"
)
if not defined 7ZIP_FILE (
    echo     [X] Instalador do 7-Zip nao encontrado
    goto :eof
)
echo     [*] Instalando 7-Zip: !7ZIP_FILE!
start "" /wait "!7ZIP_FILE!" /S
echo     [+] 7-Zip instalado com sucesso
set /a PROGRAMAS_INSTALADOS+=1
goto :eof

:instalar_anydesk
echo [5/11] Verificando AnyDesk...
where anydesk >nul 2>&1
if %errorlevel% equ 0 (
    echo     [!] AnyDesk ja esta instalado
    set /a PROGRAMAS_PULADOS+=1
    goto :eof
)
if not defined ANYDESK_FILE (
    for %%F in ("%PASTA_PROGRAMAS%\*anydesk*") do if exist "%%F" set "ANYDESK_FILE=%%F"
)
if not defined ANYDESK_FILE (
    echo     [X] Instalador do AnyDesk nao encontrado
    goto :eof
)
echo     [*] Instalando AnyDesk: !ANYDESK_FILE!
start "" /wait "!ANYDESK_FILE!" --install "C:\Program Files (x86)\AnyDesk" --start-with-win --silent
echo     [+] AnyDesk instalado com sucesso
set /a PROGRAMAS_INSTALADOS+=1
goto :eof

:instalar_ndd
echo [6/11] Verificando NDD Print Agent...
where nddPrintAgent >nul 2>&1
if %errorlevel% equ 0 (
    echo     [!] NDD Print Agent ja esta instalado
    set /a PROGRAMAS_PULADOS+=1
    goto :eof
)
if not defined NDD_FILE (
    for %%F in ("%PASTA_PROGRAMAS%\*ndd*") do if exist "%%F" set "NDD_FILE=%%F"
)
if not defined NDD_FILE (
    echo     [X] Instalador do NDD nao encontrado
    goto :eof
)
echo     [*] Instalando NDD Print Agent: !NDD_FILE!
start "" /wait "!NDD_FILE!" /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-
echo     [+] NDD Print Agent instalado com sucesso
set /a PROGRAMAS_INSTALADOS+=1
goto :eof

:instalar_teams
echo [7/11] Verificando Microsoft Teams...
where teams >nul 2>&1
if %errorlevel% equ 0 (
    echo     [!] Teams ja esta instalado
    set /a PROGRAMAS_PULADOS+=1
    goto :eof
)
if not defined TEAMS_FILE (
    for %%F in ("%PASTA_PROGRAMAS%\*teams*") do if exist "%%F" set "TEAMS_FILE=%%F"
)
if not defined TEAMS_FILE (
    echo     [X] Instalador do Teams nao encontrado
    goto :eof
)
echo     [*] Instalando Microsoft Teams: !TEAMS_FILE!
start "" /wait "!TEAMS_FILE!" -s
echo     [+] Microsoft Teams instalado com sucesso
set /a PROGRAMAS_INSTALADOS+=1
goto :eof

:instalar_java
echo [8/11] Verificando Java Runtime...
where java >nul 2>&1
if %errorlevel% equ 0 (
    echo     [!] Java ja esta instalado
    set /a PROGRAMAS_PULADOS+=1
    goto :eof
)
if not defined JAVA_FILE (
    for %%F in ("%PASTA_PROGRAMAS%\*java*") do if exist "%%F" set "JAVA_FILE=%%F"
)
if not defined JAVA_FILE (
    echo     [X] Instalador do Java nao encontrado
    goto :eof
)
echo     [*] Instalando Java Runtime: !JAVA_FILE!
start "" /wait "!JAVA_FILE!" /s INSTALL_SILENT=1 AUTO_UPDATE=0
echo     [+] Java Runtime instalado com sucesso
set /a PROGRAMAS_INSTALADOS+=1
goto :eof

:instalar_forticlient
echo [9/11] Verificando FortiClient VPN...
where forticlient >nul 2>&1
if %errorlevel% equ 0 (
    echo     [!] FortiClient ja esta instalado
    set /a PROGRAMAS_PULADOS+=1
    goto :eof
)
if not defined FORTI_FILE (
    for %%F in ("%PASTA_PROGRAMAS%\*forti*") do if exist "%%F" set "FORTI_FILE=%%F"
)
if not defined FORTI_FILE (
    echo     [X] Instalador do FortiClient nao encontrado
    goto :eof
)
echo     [*] Instalando FortiClient VPN: !FORTI_FILE!
start "" /wait "!FORTI_FILE!" /quiet /norestart
echo     [+] FortiClient VPN instalado com sucesso
set /a PROGRAMAS_INSTALADOS+=1
goto :eof

:instalar_foxit
echo [10/11] Verificando Foxit PDF Reader...
where foxitreader >nul 2>&1
if %errorlevel% equ 0 (
    echo     [!] Foxit PDF Reader ja esta instalado
    set /a PROGRAMAS_PULADOS+=1
    goto :eof
)
if not defined FOXIT_FILE (
    for %%F in ("%PASTA_PROGRAMAS%\*foxit*") do if exist "%%F" set "FOXIT_FILE=%%F"
)
if not defined FOXIT_FILE (
    echo     [X] Instalador do Foxit nao encontrado
    goto :eof
)
echo     [*] Instalando Foxit PDF Reader: !FOXIT_FILE!
start "" /wait "!FOXIT_FILE!" /quiet
echo     [+] Foxit PDF Reader instalado com sucesso
set /a PROGRAMAS_INSTALADOS+=1
goto :eof

:instalar_office
echo [11/11] Verificando Office 365...
reg query "HKLM\SOFTWARE\Microsoft\Office\16.0\Common\InstallRoot" >nul 2>&1
if %errorlevel% equ 0 (
    echo     [!] Office 365 ja esta instalado
    set /a PROGRAMAS_PULADOS+=1
    goto :eof
)
if not defined OFFICE_FILE (
    for %%F in ("%PASTA_PROGRAMAS%\*office*") do if exist "%%F" set "OFFICE_FILE=%%F"
)
if not defined OFFICE_FILE (
    echo     [X] Instalador do Office nao encontrado
    goto :eof
)
echo     [*] Instalando Office 365: !OFFICE_FILE!
start "" /wait "!OFFICE_FILE!" /configure configuration.xml
echo     [+] Office 365 instalado com sucesso
set /a PROGRAMAS_INSTALADOS+=1
goto :eof

:redes
cls
echo.
echo  ================================================================
echo                         FERRAMENTAS DE REDE
echo  ================================================================
echo.
echo  [1]  Limpeza de DNS
echo  [2]  Diagnostico de rede completo
echo  [3]  Reset de configuracoes de rede
echo  [4]  Informacoes detalhadas de rede
echo  [5]  Testar conectividade
echo.
echo  [0]  VOLTAR
echo  ================================================================
echo.
set /p escolha= Selecione: 

if "%escolha%"=="1" goto flushdns
if "%escolha%"=="2" goto diagnostico_rede
if "%escolha%"=="3" goto resetnet
if "%escolha%"=="4" goto ipall
if "%escolha%"=="5" goto testar_rede
if "%escolha%"=="0" goto menu

echo.
echo  [ERRO] Opcao invalida!
timeout /t 2 >nul
goto redes

:flushdns
cls
echo [*] Limpando DNS...
ipconfig /flushdns >nul 2>&1
ipconfig /registerdns >nul 2>&1
echo [+] DNS limpo!
pause
goto redes

:diagnostico_rede
cls
echo [*] Executando diagnostico completo de rede...
echo.
ipconfig /all
echo.
ping 8.8.8.8 -n 4
echo.
tracert 8.8.8.8
echo.
netsh interface show interface
pause
goto redes

:resetnet
cls
echo [*] Resetando rede...
netsh winsock reset >nul 2>&1
netsh int ip reset >nul 2>&1
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1
echo [+] Rede resetada!
pause
goto redes

:ipall
cls
echo [*] Coletando informacoes de rede...
ipconfig /all > "%TEMP%\rede_info.txt"
arp -a >> "%TEMP%\rede_info.txt"
route print >> "%TEMP%\rede_info.txt"
netstat -ano >> "%TEMP%\rede_info.txt"
start notepad "%TEMP%\rede_info.txt"
goto redes

:testar_rede
cls
echo [*] Testando conectividade...
echo.
ping google.com -n 4
echo.
ping 8.8.8.8 -n 4
echo.
nslookup google.com
pause
goto redes

:dispositivos
cls
echo.
echo  ================================================================
echo                    GERENCIAMENTO DE DISPOSITIVOS
echo  ================================================================
echo.
echo  [1]  Correcao de problemas de impressao
echo  [2]  Gerenciar impressoras
echo  [3]  Gerenciador de dispositivos
echo  [4]  Problemas de audio
echo  [5]  Problemas de video
echo  [6]  Drivers e hardware
echo  [7]  NDD - Servidor de Impressao
echo.
echo  [0]  VOLTAR
echo  ================================================================
echo.
set /p escolha= Selecione: 

if "%escolha%"=="1" goto correcao_impressao
if "%escolha%"=="2" goto impressoras
if "%escolha%"=="3" goto gerenciador_dispositivos
if "%escolha%"=="4" goto problemas_audio
if "%escolha%"=="5" goto problemas_video
if "%escolha%"=="6" goto drivers_hardware
if "%escolha%"=="7" goto ndd_servidor
if "%escolha%"=="0" goto menu

echo.
echo  [ERRO] Opcao invalida!
timeout /t 2 >nul
goto dispositivos

:ndd_servidor
cls
echo.
echo  ================================================================
echo               NDD - ACESSO AO SERVIDOR DE IMPRESSAO
echo  ================================================================
echo.
echo  [*] Abrindo servidor de impressao NDD...
echo  [*] Caminho: \\prdprt-srv01
echo.
start explorer "\\prdprt-srv01"
echo  [+] Servidor de impressao aberto!
echo.
echo  Pressione qualquer tecla para voltar...
pause >nul
goto dispositivos

:correcao_impressao
cls
echo.
echo  ==================================
echo   CORRECAO DE PROBLEMAS DE IMPRESSAO
echo  ==================================
echo.
echo  [1] Erro 0x0000011b (RPC)
echo  [2] Erro 0x00000bcb (Drivers)
echo  [3] Erro 0x00000709 (NamedPipe)
echo  [4] Reiniciar servico de impressao
echo  [5] Todos os reparos
echo  [0] Voltar
echo  ==================================
echo.
set /p escolha= Selecione: 

if "%escolha%"=="1" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f >nul 2>&1
    echo [+] Erro 0x0000011b corrigido!
    pause
    goto correcao_impressao
)
if "%escolha%"=="2" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" /v RestrictDriverInstallationToAdministrators /t REG_DWORD /d 0 /f >nul 2>&1
    echo [+] Erro 0x00000bcb corrigido!
    pause
    goto correcao_impressao
)
if "%escolha%"=="3" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\RPC" /v RpcUseNamedPipeProtocol /t REG_DWORD /d 1 /f >nul 2>&1
    echo [+] Erro 0x00000709 corrigido!
    pause
    goto correcao_impressao
)
if "%escolha%"=="4" (
    net stop spooler /y >nul 2>&1
    net start spooler >nul 2>&1
    echo [+] Servico de impressao reiniciado!
    pause
    goto correcao_impressao
)
if "%escolha%"=="5" (
    cls
    echo [*] Aplicando todos os reparos...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" /v RestrictDriverInstallationToAdministrators /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\RPC" /v RpcUseNamedPipeProtocol /t REG_DWORD /d 1 /f >nul 2>&1
    net stop spooler /y >nul 2>&1
    net start spooler >nul 2>&1
    echo [+] Todos os reparos aplicados!
    pause
    goto correcao_impressao
)
if "%escolha%"=="0" goto dispositivos
goto correcao_impressao

:impressoras
start control printers
echo [*] Painel de impressoras aberto!
timeout /t 2 >nul
goto dispositivos

:gerenciador_dispositivos
start devmgmt.msc
echo [*] Gerenciador de dispositivos aberto!
timeout /t 2 >nul
goto dispositivos

:problemas_audio
cls
echo [*] Diagnosticando problemas de audio...
echo.
echo [1] Reinstalar drivers de audio
echo [2] Verificar servicos de audio
echo [3] Testar dispositivos de audio
echo.
set /p audio_opcao= Selecione: 
if "%audio_opcao%"=="1" (
    devcon restart *audio*
    echo [+] Drivers de audio reinstalados!
)
if "%audio_opcao%"=="2" (
    sc query Audiosrv
    sc query AudioEndpointBuilder
    echo [+] Servicos de audio verificados!
)
pause
goto dispositivos

:problemas_video
cls
echo [*] Diagnosticando problemas de video...
echo.
echo [1] Reinstalar drivers de video
echo [2] Verificar resolucao
echo.
set /p video_opcao= Selecione: 
if "%video_opcao%"=="1" (
    devcon restart *display*
    echo [+] Drivers de video reinstalados!
)
if "%video_opcao%"=="2" (
    wmic desktopmonitor get screenheight,screenwidth
    echo [+] Resolucao verificada!
)
pause
goto dispositivos

:drivers_hardware
cls
echo [*] Informacoes de drivers e hardware...
driverquery /v
echo.
echo Pressione qualquer tecla para continuar...
pause >nul
goto dispositivos

:gerenciador
cls
echo.
echo  ================================================================
echo                   GERENCIADOR DE TAREFAS AVANCADO
echo  ================================================================
echo.
echo  [1]  Monitor de processos
echo  [2]  Diagnostico completo do sistema
echo  [3]  Auditoria do sistema
echo  [4]  Desempenho e recursos
echo  [5]  Servicos em execucao
echo  [6]  Limpeza e otimizacao
echo.
echo  [0]  VOLTAR
echo  ================================================================
echo.
set /p escolha= Selecione: 

if "%escolha%"=="1" goto processos
if "%escolha%"=="2" goto diagnostico
if "%escolha%"=="3" goto auditoria
if "%escolha%"=="4" goto desempenho
if "%escolha%"=="5" goto servicos
if "%escolha%"=="6" goto limpeza
if "%escolha%"=="0" goto menu

echo.
echo  [ERRO] Opcao invalida!
timeout /t 2 >nul
goto gerenciador

:processos
cls
echo.
echo  ==================================
echo   MONITOR DE PROCESSOS
echo  ==================================
echo.
echo  [1] Processos por CPU
echo  [2] Processos por memoria
echo  [3] Conexoes de rede
echo  [4] Servicos em execucao
echo  [5] Finalizar processo
echo  [0] Voltar
echo  ==================================
echo.
set /p escolha= Selecione: 

if "%escolha%"=="1" (
    tasklist
    pause
    goto processos
)
if "%escolha%"=="2" (
    tasklist /fi "memusage gt 10000"
    pause
    goto processos
)
if "%escolha%"=="3" (
    netstat -ano
    pause
    goto processos
)
if "%escolha%"=="4" (
    tasklist /svc
    pause
    goto processos
)
if "%escolha%"=="5" (
    set /p pid= Digite o PID: 
    taskkill /f /pid !pid! 2>nul
    pause
    goto processos
)
if "%escolha%"=="0" goto gerenciador
goto processos

:diagnostico
cls
echo.
echo  ==================================
echo   DIAGNOSTICO COMPLETO DO SISTEMA
echo  ==================================
echo.
echo  [1] Verificar arquivos (SFC)
echo  [2] Verificar imagem (DISM)
echo  [3] Verificar disco (CHKDSK)
echo  [4] Verificar drivers
echo  [5] Verificar atualizacoes
echo  [6] Executar TODOS
echo  [0] Voltar
echo  ==================================
echo.
set /p escolha= Selecione: 

if "%escolha%"=="1" (
    sfc /scannow
    pause
    goto diagnostico
)
if "%escolha%"=="2" (
    DISM /Online /Cleanup-Image /RestoreHealth
    pause
    goto diagnostico
)
if "%escolha%"=="3" (
    chkdsk /scan
    pause
    goto diagnostico
)
if "%escolha%"=="4" (
    driverquery /v
    pause
    goto diagnostico
)
if "%escolha%"=="5" (
    start ms-settings:windowsupdate
    pause
    goto diagnostico
)
if "%escolha%"=="6" (
    echo [*] Diagnostico completo iniciado...
    sfc /scannow
    DISM /Online /Cleanup-Image /RestoreHealth
    chkdsk /scan
    driverquery /v
    echo [+] Diagnostico concluido!
    pause
    goto diagnostico
)
if "%escolha%"=="0" goto gerenciador
goto diagnostico

:auditoria
cls
echo.
echo  ==================================
echo   AUDITORIA DO SISTEMA
echo  ==================================
echo.
echo  [1] Verificar erros do sistema
echo  [2] Eventos de seguranca
echo  [3] Relatorio de desempenho
echo  [4] Verificar integridade
echo  [0] Voltar
echo  ==================================
echo.
set /p escolha= Selecione: 

if "%escolha%"=="1" (
    wevtutil qe System /c:10 /rd:true /f:text
    pause
    goto auditoria
)
if "%escolha%"=="2" (
    start eventvwr.msc
    timeout /t 2 >nul
    goto auditoria
)
if "%escolha%"=="3" (
    start perfmon /report
    timeout /t 2 >nul
    goto auditoria
)
if "%escolha%"=="4" (
    systeminfo
    pause
    goto auditoria
)
if "%escolha%"=="0" goto gerenciador
goto auditoria

:desempenho
cls
echo [*] Analisando desempenho do sistema...
echo.
wmic cpu get loadpercentage
echo.
wmic OS get FreePhysicalMemory,TotalVisibleMemorySize /value
echo.
powercfg /getactivescheme
pause
goto gerenciador

:servicos
cls
echo [*] Servicos em execucao...
sc query | find "RUNNING"
echo.
echo Pressione qualquer tecla para continuar...
pause >nul
goto gerenciador

:limpeza
cls
echo.
echo  ==================================
echo   LIMPEZA E OTIMIZACAO
echo  ==================================
echo.
echo  [1] Limpar arquivos temporarios
echo  [2] Otimizacao de energia
echo  [3] Desativar apps desnecessarios
echo  [4] Backup do registro
echo  [0] Voltar
echo  ==================================
echo.
set /p escolha= Selecione: 

if "%escolha%"=="1" (
    call :clean_temp
    pause
    goto limpeza
)
if "%escolha%"=="2" (
    call :energia
    pause
    goto limpeza
)
if "%escolha%"=="3" (
    call :desativarapps
    pause
    goto limpeza
)
if "%escolha%"=="4" (
    call :backupreg
    pause
    goto limpeza
)
if "%escolha%"=="0" goto gerenciador
goto limpeza

:configuracoes
cls
echo.
echo  ==================================
echo   CONFIGURACOES DO SISTEMA
echo  ==================================
echo.
echo  [1] Gerenciador de tarefas
echo  [2] Configuracoes do Windows
echo  [3] Painel de controle
echo  [4] Gerenciador de dispositivos
echo  [5] Gerenciador de discos
echo  [0] Voltar
echo  ==================================
echo.
set /p escolha= Selecione: 

if "%escolha%"=="1" start taskmgr
if "%escolha%"=="2" start ms-settings:
if "%escolha%"=="3" start control
if "%escolha%"=="4" start devmgmt.msc
if "%escolha%"=="5" start diskmgmt.msc
if "%escolha%"=="0" goto menu
timeout /t 1 >nul
goto configuracoes

:backupreg
cls
echo [*] Criando backup do registro...
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value 2^>nul') do set datetime=%%I
set BACKUP_DIR=C:\RegBackup_%datetime:~0,8%
mkdir "%BACKUP_DIR%" >nul 2>&1
reg export HKLM "%BACKUP_DIR%\HKLM.reg" /y >nul 2>&1
reg export HKCU "%BACKUP_DIR%\HKCU.reg" /y >nul 2>&1
echo [+] Backup salvo em: %BACKUP_DIR%
goto :eof

:clean_temp
echo [*] Limpando arquivos temporarios...
del /f /s /q "%temp%\*" >nul 2>&1
del /f /s /q "C:\Windows\Temp\*" >nul 2>&1
del /f /s /q "C:\Windows\Prefetch\*" >nul 2>&1
echo [+] Limpeza concluida!
goto :eof

:energia
echo [*] Otimizando energia...
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
powercfg /change standby-timeout-ac 0 >nul 2>&1
powercfg /change standby-timeout-dc 0 >nul 2>&1
powercfg /getactivescheme
goto :eof

:desativarapps
echo [*] Desativando apps desnecessarios...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul 2>&1
sc config "DiagTrack" start= disabled >nul 2>&1
sc config "dmwappushservice" start= disabled >nul 2>&1
echo [+] Apps desativados!
goto :eof

:fim
cls
echo.
echo  ================================================================
echo   Obrigado por usar o ERROR KILLER - DIAGONAL!
echo  ================================================================
echo.
timeout /t 3 >nul
exit
