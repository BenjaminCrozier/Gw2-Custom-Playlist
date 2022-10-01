# Youtube Playlist -> GW2 Custom Sound Track 
Extends TheCheatsrichter's terrific custom Guild Wars 2 Playlist batch file to automatically download playlists from youtube. 

This addition will allows users to constantly update their GW2 playlist via the youtube app (just remember to re-run this batch file). 

**Compile your own playlist on youtube or find one online!**

## Instructions
Replace the playlist ID's found in `playlist.csv` with your own: 

**EXAMPLE**

    MainMenu,PLktdtTNubKSofHsICrxW9KE9DeFPFYqoG
    Underwater,PLfP6i5T0-DkKt8eo7u222EnUO4N7Q3raT
    Ambient, (...)

Here our main menu (MainMenu) Playlist ID is "PLktdtTNubKSofHsICrxW9KE9DeFPFYqoG"  
And it can be found readily inside it's url on youtube:  
https://www.youtube.com/watch?v=2a-VL1VoHJ0&list=PLktdtTNubKSofHsICrxW9KE9DeFPFYqoG

* Replace the Playlist ID's with your own
* Do not change the first column of the CSV
* Similarly, do not change the filetype (CSV) if you're using excel or something similar

## Notes
This batch downloads and runs [youtube-dl](https://ytdl-org.github.io/youtube-dl/about.html) and [ffmpeg](https://ffmpeg.org/about.html) executables automatically.  
They are essential to this script. 