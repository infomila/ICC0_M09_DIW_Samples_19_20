<#
    1080p 1920x1080 (original)
    720p 1280x720
    480p 842x480
    360p 640x360
#>

Param (
$name = "Rogue.mp4",
$height = @("360", "480", "720", "1080"),
$width = @("640", "842", "1280", "1920"),
$bitrate = @("800k", "1400k", "2800k", "5000k"),
$maxrate = @("856k", "1498k", "2996k", "5350k"),
$bufsize = @("1200k", "2100k", "4200k", "7500k"),
$audiorate = @("96k", "128k", "128k", "192k" )
)

$master = "#EXTM3U`n" +
          "#EXT-X-VERSION:3`n"
echo $master


for ($i=0; $i -lt $bitrate.length; $i++) {
	
    
    
    $reprentation = "#EXT-X-STREAM-INF:BANDWIDTH=$($bitrate[$i]),RESOLUTION=$($width[$i])x$($height[$i])"
    
    $reprentation = $reprentation -replace 'k','000'
    
    $master = $master + $reprentation + "`n"
    $master = $master + "$($width[$i])p/$($width[$i]).m3u8`n"
    
    
    $path =  "$($width[$i])p" 
     
    New-Item -ItemType Directory -Force  -Path $path
    
   
    $ffmpegpath = '"E:\Docencia\Material_Moduls\M9_DIW\material_curs\UFO2\video\01_programes de conversio\ffmpeg\binaris\bin\ffmpeg.exe"'
 
    $vf =  "scale=w=$($width[$i]):h=$($height[$i]):force_original_aspect_ratio=decrease"
   
    $command = " & $($ffmpegpath) -i $name -f hls -vf $vf -c:a aac -ar 48000 -b:a 128k -c:v libx264 -x264opts keyint=48:min-keyint=48:no-scenecut -profile:v main -crf 20 -g 48 -keyint_min 48 -sc_threshold 0 -b:v $($bitrate[$i]) -maxrate $($maxrate[$i]) -bufsize $($bufsize[$i]) -hls_time 4 -hls_playlist_type vod -master_pl_name master.m3u8 -hls_segment_filename $($width[$i])p/$($width[$i])p_%03d.ts $($width[$i])p/$($width[$i]).m3u8"
   
      
      
   Invoke-Expression  $command   
    
}

echo $master > "playlist.m3u8"





<#
 -b:v 800k -maxrate 856k  -bufsize 1200k -b:a 96k -
-b:v 1400k -maxrate 1498k -bufsize 2100k -b:a 128k 
-b:v 2800k -maxrate 2996k -bufsize 4200k -b:a 128k 
-b:v 5000k -maxrate 5350k -bufsize 7500k -b:a 192k 
 ffmpeg -i beach.mkv -vf scale=w=1280:h=720:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -b:a 128k -c:v h264 -profile:v main -crf 20 -g 48 -keyint_min 48 -sc_threshold 0 -b:v 2500k -maxrate 2675k -bufsize 3750k -hls_time 4 -hls_playlist_type vod -hls_segment_filename beach/720p_%03d.ts beach/720p.m3u8

#>

