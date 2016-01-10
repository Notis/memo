ffmpeg.exe -i output.avi -vf scale=1280x720 -vcodec libx264 -g 75 -vb 4000k -vprofile high -level 40 -s 1280x720 -acodec aac -strict -2 -pass 1 compleate.mp4
ffmpeg.exe -i output.avi -vf scale=1280x720 -vcodec libx264 -g 75 -vb 4000k -vprofile high -level 40 -s 1280x720 -acodec aac -strict -2 -pass 2 -y compleate.mp4
