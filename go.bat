@echo off
color 02
set _MAINPATH_=%~dp0
set _MPATH_=%_MAINPATH_%CustomPlaylist\
set _LPATH_=%_MAINPATH_%log\

echo "GW2 Custom Playlist Rev 2.1 by TheCheatsrichter + BC"

echo.
echo This batch will automatically create folders
echo in which you can place your custom audio files
echo for Guild Wars 2.
echo.
echo It will also download music from youtube via youtube-dl
echo.
echo Supported formats are:
echo 	*.mp3 *.aiff *.flac *.ogg *.wav
echo.
echo.
echo This batch will:
echo 	*)create subfolders for each playlist
echo 	*)source playlists from youtube and download
echo 	*)generate playlists in .m3u formats
echo 	*)setup the playlists to work with GuildWars2
echo.
echo 	Press any key to start by creating the Playlist folders
pause

@REM Replace these youtube playlist ID's with your own! 
set T[0]=MainMenu
set P[0]=PLktdtTNubKSofHsICrxW9KE9DeFPFYqoG

set T[1]=Underwater
set P[1]=PLfP6i5T0-DkKt8eo7u222EnUO4N7Q3raT

set T[2]=Ambient
set P[2]=PLwd1f7679ZuL1foxHMSQYyb5HBjjWkjUe

set T[3]=NightTime
set P[3]=PL7pkSK1xbGD5PB34Ol68utSbqeKIBdwna

set T[4]=Defeated
set P[4]=PLfP6i5T0-DkIMnLY0r17o_kOOsVtQIJIX

set T[5]=City
set P[5]=PLPWDeTGQ3-6aSk8zRQMY-7P_07CmFghf0

set T[6]=Battle
set P[6]=PLW_Ogmr0b_5vDo9mB_vEMiJNybc9eme-9

set T[7]=BossBattle
set P[7]=PLLEnbi5KRv6Z8CMUtLiA81-wQCLVUOKYs

set T[8]=Victory
set P[8]=PLT6P4kQFSBOOvuSV_KMcNV2Z_EiI2t6bE

set T[9]=Crafting
set P[9]=PL904AuFDEgehp5ZQz_pkjWd05umUzi4QP

:makedir
echo [+] Building DIR structure ...

If NOT EXIST "%_MPATH_%" mkdir "%_MPATH_%"
If NOT EXIST "%_LPATH_%" mkdir "%_LPATH_%"
If NOT EXIST "%_MPATH_%#Playlists" mkdir "%_MPATH_%#Playlists"

FOR %%G IN (%T%) DO (IF NOT EXIST "%_MPATH_%%%G" (mkdir "%_MPATH_%%%G" & echo [+] %%G folder created! ) else ( echo [*] Folder %%G allready created))
echo.
echo.

FOR /L %%i IN (0 1 9) DO  (
    SETLOCAL
	
    call set title=%%T[%%i]%%
    call set playlistID=%%P[%%i]%%

    @REM get save path 
    call SET savePath=".\CustomPlaylist\%%title%%\%%%%(title)s.%%%%(ext)s"

    @REM run youtube-dl
    call youtube-dl -x --audio-format mp3 -o %%savePath%% -i %%playlistID%% --download-archive %%_LPATH_%%\%%title%%.log

    ENDLOCAL    
)

:makeplaylists
FOR %%G IN (%T%) DO (
	chdir "%_MPATH_%%%G"
	echo [+] Building %%G.m3u ...
	dir /o:n/a/b/s *.mp3 *.aiff *.flac *.ogg *.wav >"%_MPATH_%#Playlists\%%G.m3u" || (del "%_MPATH_%#Playlists\%%G.m3u" && echo [*] %%G folder is empty...)
	)
	
echo.
echo.
echo [+] Playlists Successfully created!
echo.
:readapply
set /p w=[*]Do you want to apply them now [y/n]?:

:copyplaylists
If NOT EXIST "%HOMEPATH%\Documents\Guild Wars 2" (
	color 0C
	echo [-] %HOMEPATH%\Documents\Guild Wars 2 not found!
	echo [-] Please manually copy the playlist files or force copy process 
	set /p w=[*]Force copy process [y/n]?:
	if not "%w%" == "y" (
		echo [-] Closing batch...
		goto eof
	)
	
)
If NOT EXIST "%HOMEPATH%\Documents\Guild Wars 2\Music" mkdir "%HOMEPATH%\Documents\Guild Wars 2\Music"

if "%w%" == "y" (
	xcopy /y /s "%_MPATH_%#Playlists" "%HOMEPATH%\Documents\Guild Wars 2\Music"  > nul
	echo [+] Playlists successfully applied!
	echo [+] Please restart GuildWars2 if its currently running!
	echo [+] Have fun! Greetings TheCheatsrichter!
	color 0A
	) else (
	echo.
	echo [-] Playlists not applied!
	color 0C
	)
pause
