for %%i in (*.mkv) do "C:/Program Files/MKVToolNix\mkvmerge.exe" --output "2%%i" --language 1:jpn --track-name 1:Japanese --default-track 1:yes --language 2:eng --track-name 2:English --sub-charset 3:UTF-8 --language 3:jpn --sub-charset 4:UTF-8 --language 4:eng --default-track 3:yes --language 0:und --default-track 0:yes "%%i" --track-order 0:0,0:1,0:2,0:3,0:4
pause