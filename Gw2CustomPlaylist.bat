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


:makedir
echo [+] Building DIR structure ...
If NOT EXIST "%_MPATH_%" mkdir "%_MPATH_%"
If NOT EXIST "%_LPATH_%" mkdir "%_LPATH_%"
If NOT EXIST "%_MPATH_%#Playlists" mkdir "%_MPATH_%#Playlists"

FOR %%G IN (Ambient Battle BossBattle City Defeated MainMenu NightTime Underwater Victory Crafting) DO (IF NOT EXIST "%_MPATH_%%%G" (mkdir "%_MPATH_%%%G" & echo [+] %%G folder created! ) else ( echo [*] Folder %%G allready created))
echo.
echo.

@REM Replace these youtube playlist ID's with your own!
set t[0]=MainMenu
set p[0]=PLFhB40nM1iSpRoLIuGBOO52lejOeSA0-4

@REM set t[1]=Underwater
@REM set p[1]=PLgNxd3KRDkEfVXOiltMiBCAqI4dHIFkdm

@REM set t[2]=Ambient
@REM set p[2]=PLgNxd3KRDkEd5jrDbz8BE3tI27zFb1ii6

@REM set t[3]=NightTime
@REM set p[3]=PLgNxd3KRDkEe2K-7XrWqFYyZHbj_vOzTK

@REM set t[4]=Defeated
@REM set p[4]=PLgNxd3KRDkEdwSBziS1Z_KP540Z0txxr9

@REM set t[5]=City
@REM set p[5]=PLgNxd3KRDkEfdpiRtXkozkTngwP33eUbk

@REM set t[6]=Battle
@REM set p[6]=PLgNxd3KRDkEctGuAeQe2rddOXCsC-lxy-

@REM set t[7]=BossBattle
@REM set p[7]=PLgNxd3KRDkEeTLcWV36uzdO3Omjx3Khq_

@REM set t[8]=Victory
@REM set p[8]=PLgNxd3KRDkEd5iCNNbGPsMffFN3fPvqEo

@REM set t[9]=Crafting
@REM set p[9]=PLgNxd3KRDkEfkiWyt8Yq2uZwdOnbd_l6h


@echo off
FOR /L %%i IN (0 1 9) DO  (
    SETLOCAL
	
    call set title=%%t[%%i]%%
    call set playlistID=%%p[%%i]%%

    @REM get save path 
    call SET savePath=".\CustomPlaylist\%%title%%\%%%%(title)s.%%%%(ext)s"

    @REM run youtube-dl
    call youtube-dl -x --audio-format mp3 -o %%savePath%% -i %%playlistID%% --download-archive %%_LPATH_%%\%%title%%.log

    ENDLOCAL    
)

:makeplaylists
FOR %%G IN (Ambient Battle BossBattle City Defeated MainMenu NightTime Underwater Victory Crafting) DO (
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
