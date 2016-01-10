ffmpeg -i comp1.avi -i out.mp3 -c:v copy -c:a mp3 -strict experimental -map 0:v:0 -map 1:a:0 output.avi
