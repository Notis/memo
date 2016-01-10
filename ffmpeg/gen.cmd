ffmpeg.exe -framerate 5 -loop 1 -i b%01d.jpg -preset veryfast -crf 28 -vf "fps=25,format=yuv420p" -t 00:00:14 out1.avi
