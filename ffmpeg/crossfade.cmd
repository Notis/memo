ffmpeg -i out.avi -i out1.avi -f lavfi -i color=black -filter_complex "[0:v]format=pix_fmts=yuva420p,fade=t=out:st=9:d=1:alpha=1,setpts=PTS-STARTPTS[va0]; [1:v]format=pix_fmts=yuva420p,fade=t=in:st=0:d=1:alpha=1,setpts=PTS-STARTPTS+9/TB[va1]; [2:v]scale=4928x3264,trim=duration=24[over]; [over][va0]overlay[over1]; [over1][va1]overlay=format=yuv420[outv]"  -vcodec libx264 -map [outv] comp.avi
