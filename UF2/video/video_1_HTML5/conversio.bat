
set PATH=%PATH%;"E:\Docencia\Material_Moduls\M9_DIW\material_curs\UFO2\video\01_programes de conversio\ffmpeg\binaris\bin"
rem ================================
rem     PARÀMETRES DE CONVERSIÓ
rem ================================
set NAME=back
set INPUT=%NAME%.mp4
set RESOLUTION=886x480
set BW=0.4M
set FILTRE=-vf hue=s=0
rem ================================
ffprobe -i %INPUT%

ffmpeg -h


rem ffmpeg -i %INPUT% -c:v libx264 %FILTRE% -s %RESOLUTION% -b:v %BW% %NAME%_out_grayscale.mp4
ffmpeg -i %INPUT% -c:v libvpx %FILTRE%  -s %RESOLUTION% -b:v %BW% %NAME%.webm
ffmpeg -i %INPUT% -c:v libtheora %FILTRE% -s %RESOLUTION% -b:v %BW% %NAME%.ogv
pause
