@Echo off

timeout 3600

For /f "delims=" %%A in ('
Powershell -NoP -C "('%~1' -Split ' - ')[1]"
') Do Set "NewName=%%A%~x1"
Set NewName
Set nom=%NewName:~0,-27%

echo %nom%
echo %~1

set "ff=[AniDL] Mars Red - "

call set ffxx=%%ff%%%nom%%

echo %ffxx%

set "l1= [WEB 480p 10bit][SubsPlease]"
set "l2= [WEB 720p 10bit][SubsPlease]"
set "l3= [WEB 1080p 10bit][SubsPlease]"

call set r1=%%ffxx%%%l1%%
call set r2=%%ffxx%%%l2%%
call set r3=%%ffxx%%%l3%%

echo %r1%
echo %r2%
echo %r3%

del tempMars.mkv

"C:/Program Files/MKVToolNix\mkvmerge.exe" --output "tempMars.mkv" --language 1:jpn --track-name 1:Japanese --default-track 1:yes --sub-charset 2:UTF-8 --language 2:eng --track-name ^"2:English subs^" --default-track 2:yes --language 0:und --default-track 0:yes "%~1" --split timestamps:7s --track-order 0:0,0:1,0:2

del "*001.mkv"

ren "tempMars-002.mkv" "tempMars.mkv"

echo "Fixing Color range"

ffmpeg -y -hide_banner -v quiet -stats -i "tempMars.mkv" -c copy -bsf:v h264_metadata=video_full_range_flag=1 -color_range 0 "atempMars.mkv"

set "fi=atempMars.mkv"

echo %fi%

vspipe --y4m marsred.vpy --arg key="%fi%" - | ffmpeg -hide_banner -v quiet -stats -y -f yuv4mpegpipe -i - -s 854x356 -c:v libx265 -x265-params "limit-sao=1:bframes=8:psy-rd=1.5:psy-rdoq=2:aq-mode=3" -crf 22 -pix_fmt yuv420p10le -preset slow -map 0 -movflags faststart "%r1%1.mkv"
vspipe --y4m marsred.vpy --arg key="%fi%" - | ffmpeg -hide_banner -v quiet -stats -y -f yuv4mpegpipe -i - -s 1280x536 -c:v libx265 -x265-params "limit-sao=1:bframes=8:psy-rd=1.5:psy-rdoq=2:aq-mode=3" -crf 22 -pix_fmt yuv420p10le -preset slow -map 0 -movflags faststart "%r2%1.mkv"
vspipe --y4m marsred.vpy --arg key="%fi%" - | ffmpeg -hide_banner -v quiet -stats -y -f yuv4mpegpipe -i - -s 1920x804 -c:v libx265 -x265-params "limit-sao=1:bframes=8:psy-rd=1.5:psy-rdoq=2:aq-mode=3" -crf 22 -pix_fmt yuv420p10le -preset slow -map 0 -movflags faststart "%r3%1.mkv"

ffmpeg -hide_banner -v quiet -stats -y -canvas_size 854x356 -i "%r1%1.mkv" -i "%fi%" -map 1 -map -1:v -map 0 -c:v copy -c:a aac -ac 2 -ab 128k -map_metadata:g -1 -metadata title="[AniDL] Mars Red [WEB 480p 10bit][Soap]" -metadata:s:v title="" -metadata:s:a title="Japanese" "1%r1%.mkv"
ffmpeg -hide_banner -v quiet -stats -y -canvas_size 1280x536 -i "%r2%1.mkv" -i "%fi%" -map 1 -map -1:v -map 0 -c:v copy -c:a aac -ac 2 -ab 128k -map_metadata:g -1 -metadata title="[AniDL] Mars Red [WEB 720p 10bit][Soap]" -metadata:s:v title="" -metadata:s:a title="Japanese" "1%r2%.mkv"
ffmpeg -hide_banner -v quiet -stats -y -canvas_size 1920x804 -i "%r3%1.mkv" -i "%fi%" -map 1 -map -1:v -map 0 -c:v copy -c:a aac -ac 2 -ab 128k -map_metadata:g -1 -metadata title="[AniDL] Mars Red [WEB 1080p 10bit][Soap]" -metadata:s:v title="" -metadata:s:a title="Japanese" "1%r3%.mkv"

"C:/Program Files/MKVToolNix\mkvmerge.exe" --output "%r1%.mkv" --language 1:jpn --track-name 1:Japanese --default-track 1:yes --sub-charset 2:UTF-8 --language 2:eng --track-name ^"2:English subs^" --default-track 2:yes --language 0:und --default-track 0:yes ^"1%r1%.mkv^" --track-order 0:0,0:1,0:2
"C:/Program Files/MKVToolNix\mkvmerge.exe" --output "%r2%.mkv" --language 1:jpn --track-name 1:Japanese --default-track 1:yes --sub-charset 2:UTF-8 --language 2:eng --track-name ^"2:English subs^" --default-track 2:yes --language 0:und --default-track 0:yes ^"1%r2%.mkv^" --track-order 0:0,0:1,0:2
"C:/Program Files/MKVToolNix\mkvmerge.exe" --output "%r3%.mkv" --language 1:jpn --track-name 1:Japanese --default-track 1:yes --sub-charset 2:UTF-8 --language 2:eng --track-name ^"2:English subs^" --default-track 2:yes --language 0:und --default-track 0:yes ^"1%r3%.mkv^" --track-order 0:0,0:1,0:2

rclone copy "C:\Users\Administrator\Downloads\%r1%.mkv" "SoapEnc12:Public/[AniDL] Mars Red [WEB 480p 10bit][Soap]"
rclone copy "C:\Users\Administrator\Downloads\%r2%.mkv" "SoapEnc12:Public/[AniDL] Mars Red [WEB 720p 10bit][Soap]"
rclone copy "C:\Users\Administrator\Downloads\%r3%.mkv" "SoapEnc12:Public/[AniDL] Mars Red [WEB 1080p 10bit][Soap]"

rclone copy "C:\Users\Administrator\Downloads\%r1%.mkv" "OneDrive ceo:Public/[AniDL] Mars Red [WEB 480p 10bit][Soap]"
rclone copy "C:\Users\Administrator\Downloads\%r2%.mkv" "OneDrive ceo:Public/[AniDL] Mars Red [WEB 720p 10bit][Soap]"
rclone copy "C:\Users\Administrator\Downloads\%r3%.mkv" "OneDrive ceo:Public/[AniDL] Mars Red [WEB 1080p 10bit][Soap]"

rclone copy "C:\Users\Administrator\Downloads\%r1%.mkv" "OneDrive ceo 2:Public/[AniDL] Mars Red [WEB 480p 10bit][Soap]"
rclone copy "C:\Users\Administrator\Downloads\%r2%.mkv" "OneDrive ceo 2:Public/[AniDL] Mars Red [WEB 720p 10bit][Soap]"
rclone copy "C:\Users\Administrator\Downloads\%r3%.mkv" "OneDrive ceo 2:Public/[AniDL] Mars Red [WEB 1080p 10bit][Soap]"

del "%r1%1.mkv"
del "%r2%1.mkv"
del "%r3%1.mkv"

pause
