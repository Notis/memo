#
#
#  !!!!THIS IS NO SCRIPT FILE!!!
#
#
# just compile of bash one-string useful commands 

echo "---------\n\nTHIS IS NO SCRIPT FILE\n\n----------"
exit 0

#------------------------------list net devices
lspci | egrep -i --color 'network|ethernet'

lshw -class network

ifconfig -a

ip link show

ip a

cat /pro/net/dev

#--------------------------------
Проверить включен ли IP Forwarding можно так:
sysctl net.ipv4.ip_forward
cat /proc/sys/net/ipv4/ip_forward
Включить можно так (действовать будет до перезагрузки):
sysctl -w net.ipv4.ip_forward=1
или
echo 1 > /proc/sys/net/ipv4/ip_forward
Или жётско включить (действовать будет и после перезагрузки):
# grep forward /etc/sysctl.conf
net.ipv4.ip_forward = 1
#---------------------------------

Иногда требуется для тестов...
Код:

dd if=/dev/zero of=10g.img bs=1 count=0 seek=10G

или
Код:

truncate -s 10G 10g.img

просто вторая команда не везде есть... 
#------------------------------------------------

в одной папке
diff <(ls -1a ./dir1) <(ls -1a ./dir2)
разные пути (только имена файлов вытаскивает)
diff <(ls -1 ~/.reika/mods/*.jar | tr '\n' '\0' | xargs -0 -n 1 basename) <(ls -1 /tmp/RC/*.jar | tr '\n' '\0' | xargs -0 -n 1 basename)
#----------------------------------------------

# скачивание нескольки файлов с форматами file_001.jpg file_002.jpg ... file071.jpg
for i in {1..71} ; do printf "http://site.tld/file_%03d.jpg\n" "$i" >> test.txt ; done ; wget -i test.txt

#----------------------------------------------
# переименование всех jpg в папке в файлы вида 0001..nnnn 
i=0 ; for f in *.jpg ; do i=$[i+1] ; name=`printf "%04d.jpg" "$i"` ; mv  "$f" "$name"  ; done

# ---------------------- uzip with unicone
convmv -f cp1252 -t cp850 * --notest  && convmv -f cp866 -t utf-8 * --notest

# запись с экрана
ffmpeg -f x11grab -s 1366x768 -r 25 -i :0.0 -vcodec huffyuv /tmp/out.yuv
#================

# закачка вгетом с авторизацией

read -p "Tumblr login email: " EMAIL
read -p "Tumblr login password: " PASSWRD
wget --user-agent=Mozilla/5.0 --save-cookies cookies.txt --post-data "email=$EMAIL&password=$PASSWRD" --no-check-certificate https://www.tumblr.com/login
#------------------
wget --load-cookies=cookies.txt --post-data 'app=downloads&module=display&section=download&do=confirm_download&id=25326' --referer="http://forums.x-plane.org/" http://forums.x-plane.org/index.php && mv index.php 25326.zip
#================

#===============
обрезать 116 байт с конца и 799 сначала файла

head -c -116 | tail -c +800 
#===============

qemu-system-i386 -net nic,model=virtio -net tap,if=tap0,script=no -drive file=disk_image,media=disk,if=virtio

#============= переименование всех папок/файлов с верхним регистром в нижний ==
for n in `ls | grep -e ^[A-Z]` ; do mv $n `echo $n | tr 'A-Z' 'a-z' ` ; done
#=============
 cat symlinks.txt | awk '{print "ln -s", $2, $1}' | sed -e 's/(/\\(/' -e  's/)/\\)/' > /tmp/syml.sh
#================

#----08 уточняется как десятичная ---------ТУТ
n=08;mplayer2.exe *\ $n\ *.mp4 -sub *\ $[10#$n+12]\ \[*.ass

#=======
MARKDOWN to cli-man(TROFF)format

pandoc -s -f markdown -t man foo.md | man -l -
#=========
 
меняем размер шрифта в всех файлах сабов
sed -i 's\Gothic,53\Gothic,38\' *.ass
#===========

парсинг хтмл из bcy.net

cat test.txt | grep -e 'img.*bcyimg.com' | grep 'coser' | grep w650 | sed  's/<img class="cover" src="//' |sed 's/<img src="//' | sed -e 's/\/w650/\n/g' | sed 
-e 's/^.*http/http/'

#----- mass rename (01-10)
k=0; for i in *Raws-4U*.ass ; do ((k++)) ; mv "$i" $(printf "zannoterror_%02d" $k).ass ; done


#=====
evince -- смотрелка pdf
gqview -- смотрелка графики

#---- ищем всякое выключаем стдерр
exec 2> /dev/null ; comm -2 -3 tags227.txt alltag.txt | xargs -I {} find ../Dupes/{}  -maxdepth 0 -type d ; exec 2>&1

#-----------lpr

#print 8 margin with all edges on A4 media one page
lpr -o page-top=8 -o  page-left=8 -o  page-bottom=8 -o  page-right=8 -o media=A4  -o page-ranges=1 mozilla.pdf 

#file with options  .cups/lpoptions 

# setup lp options
lpoptions -o media=A4
lpoptions -o page-top=8 -o  page-left=8 -o  page-bottom=8 -o  page-right=8
#=================

#------
convmv -f cp1252 -t cp850 * --notest  && convmv -f cp866 -t utf-8 * --notest

#--- sort of rename
i=0 ; for f in *.jpg ; do ((i++)); fname=`printf cat%02d.jpg "$i"` ; convert "$f" -quality 80 "$fname" ; done
#=================

#--- make webm
ffmpeg -i nya.mp4 -sn -c:v vp8 -b:v 2500K -vf scale=-1:240 -quality good -threads 2 -pass 2 raw.webm
#=============

#---склейка
ffmpeg -f concat -i input.list -y -vcodec copy -acodec copy output.mp4

файл input.list внутри содержит строки:

file 'd:/tempffmpeg/mov1.ts'
file 'd:/tempffmpeg/mov2.ts'
#--------------------

#make feh vindow with zoom and none borders 1-key use for action copy image

<<<<<<< HEAD
feh -g 640x720  -ZGx --action1 "cp %F  /run/user/1000/gvfs/smb-share\:server\=192.168.0.56\,share\=cirno/dir/" 
/run/user/1000/gvfs/smb-share\:server\=192.168.0.56\,share\=cirno/anime_art/authors/name/*


#-------------------------------
# make video from images -framerate (1/5 - to 5) make time every imege
ffmpeg.exe -framerate 5 -loop 1 -i b%01d.jpg -preset veryfast -crf 28 -vf "fps=25,format=yuv420p" -t 00:00:30 out1.avi

#-------------------------------
# crossfade 960x720 - frame size
# fade st=4 && PTS-STARTPTS+4 - 4 sec where fade
# trim=duration=9  - all time
#
ffmpeg -i 1.mp4 -i 2.mp4 -f lavfi -i color=black -filter_complex \
"[0:v]format=pix_fmts=yuva420p,fade=t=out:st=4:d=1:alpha=1,setpts=PTS-STARTPTS[va0];\
[1:v]format=pix_fmts=yuva420p,fade=t=in:st=0:d=1:alpha=1,setpts=PTS-STARTPTS+4/TB[va1];\
[2:v]scale=960x720,trim=duration=9[over];\
[over][va0]overlay[over1];\
[over1][va1]overlay=format=yuv420[outv]" \
-vcodec libx264 -map [outv] out.mp4

#------------------------------
#-----crossfade 2nd variand

#   fade first and sec videos
## 76:24 mean the fade out will start frame 76 and will finish 24 frames later = 1s fade out.
## 0:25 mean the fade in will start frame 0 and will finish 25 frames later.

ffmpeg -i 1.mp4 -y -vf fade=out:76:24 1f.mp4
ffmpeg -i 2.mp4 -y -vf fade=in:0:25 2f.mp4

# convert to ts
ffmpeg -i 1f.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts 1f.ts
ffmpeg -i 2f.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts 2f.ts

# merge
ffmpeg -i "concat:1f.ts|2f.ts" -bsf:a aac_adtstoasc -c copy output.mp4
#------------------------------

#------------------
# crop to 2x3
ffmpeg.exe -i comp.avi -vf "crop=2/3*in_w:2/3*in_h" comp1.avi

#--------
# video + audio


=======
feh -g 640x720  -ZGx --action1 "cp %F  /run/user/1000/gvfs/smb-share\:server\=192.168.0.56\,share\=name/dir/" 
/run/user/1000/gvfs/smb-share\:server\=192.168.0.56\,share\=name/anime_art/authors/name/*


###
##mount options
/dev/sdb1 /mnt  -o  iocharset=utf8,codepage=866


#-----
#convert(imegemagick)
# main useful utilites [convert identify display]

# resize
# in first fix 1200x800 in second 800 pixels wide adaptivity
convert img.jpg -resize 1200x800 out.jpg
convert img.jpg -resize x800 out.jpg

# яркость контрастность
convert img.jpg -contrast-stretch 10% -modulate 80% out.jpg

#JOIN
#join horizontal
convert img1.jpg img2.jpg +append out.jpg
#join vertical
convert img1.jpg img2.jgp -append out.jpg

#BORDER
# add white 5 pixel border around (+5x+5 = imgH+5px*imgW+5px)
convert res.jpg -border 5x5 -bordercolor white out.jpg

#work_with_CD_and_DVD
#make .iso
#depricated mkisofs -r -J -iso-level 4 -o burn.iso /path
# -r Rock Rage (multisession)
# -J JOIET (for win use)
# -iso-level 4 (unlimited name len)
# -o <output_file.iso>
# Depricated mkisofs -iso-level=4 -udf -o <filename> <каталог с файлами>
# new make iso
genisoimage -iso-level 3 -J -joliet-long -rock -input-charset utf-8 -o disk.iso ./*
# -udf = UDF mode
#burn disk
 cdrecord -v -multi dev=ATAPI:0,0,0 driveropts=burnfree speed=4 burn.iso
cdrecodr wodim
# -v verbose
# -multi multisession
# dev (known from dev=ATA/ATAPI -scanbus)
# driveropts=burnfree (!!! IMPORTANT)
# speed - burn speed

## pdf  merge ps merge
#------------------------
gs -dBATCH -dNOPAUSE -q -sDEVICE=pswrite -sOutputFile=merged.ps f1.ps f2.ps f3.ps
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=merged.pdf f1.pdf f2.pdf f3.pdf

#nrg 2 iso
dd if=image.nrg of=image.iso bs=307200 skip=1

<<<<<<< HEAD
#clear CDRW-fast
cdrecord blank=fast
cdrecord blank=all

mbrowse -- snmp browser
=======
#nmap
nmap -sP 192.168.0.0/24 - fast ping scan
/cd>>>> 75843804046604735f59f294977e666841e1df53

# convert png to tiff
convert zayavk3-11.png -colors 4 -background white -alpha Remove -compress LZW  zayavk3-11.tif

#convert pdf to jpeg (resize)
convert -verbose -density 300 -trim *.pdf -quality 100 -sharpen 0x1.0 page.jpg


#NTP client command
#On to measure the frequency calibration for your system.
#If you're in a hurry, it's OK to only spend 20 minutes on this step.

ntpclient -i 60 -c 20 -h $NTPHOST >$(hostname).ntp.log &

#    Otherwise, you will learn much more about your system and its 
#    communication
#    with the NTP server by letting the log run for 24 hours.
ntpclient -i 300 -c 288 -h $NTPHOST >$(hostname).ntp.log

#gsm
ffmpeg -i oppa1.wav -acodec gsm_ms -ar 8k -ac 1 -ab 13k  oppa2.wav

vnstat - статистика сети
iperf - скорость канала
ethtool - тулы для езернетов

[I] app-text/texlive-core
[I] dev-texlive/texlive-basic
[I] dev-texlive/texlive-documentation-base
[I] dev-texlive/texlive-fontutils
[I] dev-texlive/texlive-genericrecommended
[I] dev-texlive/texlive-latex
[I] dev-texlive/texlive-latexrecommended
[I] dev-texlive/texlive-texinfo 
utf8    dev-texlive/texlive-latexextra

# gs pdf merge
gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=all.pdf -dBATCH list1.pdf list2.pdf list3.pdf


# convert MAC xx:xx:xx:xx:xx:xx to cisco xxxx.xxxx.xxxx
awk -F: '{print $1$2"."$3$4"."$5$6}'

# recode zip rus files
inzip file.zip
find . -type f -exec sh -c 'np=`echo {}|iconv -f cp1252 -t cp850| iconv -f cp866`; mv "{}" "$np"' \;

# add user borschev and add to graoup proj and nologin
useradd borschev -M -G proj -s /sbin/nologin
#list samba users (smb)
sudo pdbedit -L -v |  grep -e 'Unix\ username' -e 'Flags'

# mod user groups
usermod -aG $gorupname $username


#показать  привязку кнопок key bindings
 xmodmap -pke

#xps to pdf
gxps -o output.pdf -sDEVICE=pdfwrite input.xps

# прибавление даты
date -d '2016-09-01 + 90 day'

#convert to print(XEROX)
mkdir ./mono ; for i in *.jpg ; do convert $i -threshold 75% ./mono/$i ; done


#vim print rus
:%w !lpr

# parser samba logs
sudo cat /var/log/samba/audit.log | sed -e 's/ZUTSGW\ smbd_audit\[.*\]//' | uniq | sed -e 's/ : //'|awk -F "|" ' { printf "%s %s %s\t%s\t", $1, $2, $3, $4 }   $5 == "unlink"  {printf "\033[31m"} $5 == "rename" {print "\033[33m"} $5=="open" && $7=="w" {printf "\033[35m"} { printf "%s\033[0m %s %s\n", $5, $7, $8 } '

# date convert to DATETIME mysql and cp1251 to current locale
cat /tmp/Report_01012017-31012017_1_of_1.csv | sed -E 's,([0-9]{2}).([0-9]{2}).([0-9]{4}),\3-\2-\1,g' | iconv -f cp1251
#full_ver
cat /tmp/Report_01012017-31012017_1_of_1.csv | sed -E 's,([0-9]{2})\.([0-9]{2})\.([0-9]{4}),\3\2\1,g' | iconv -f cp1251 | cat -n | sed -e 's/^[ \t]*//' -e 's/[\t ]2017/;2017/' -e 's/://g' | sed -E 's,([0-9]{8}) ([0-9]{6}),\1\2,g' | sed -e s/\"\"// | sed -E 's, ([0-9]{4}),\100,g' > rep.data 

# генерит рандомное имя файла pwgen-ом
"$(pwgen 10 1).arc"


fdupes -r /home/user/downloads

ключ -r — заставляет искать в том числе и в подкаталогах, ниже заданного.

Перенаправление в файл — удобно, если список дубликатов слишком большой:

fdupes -r /home/user/downloads > /home/user/duplicates.txt

Поиск файлов повторяющихся более одного раза и сохранение результатов в файл:

awk 'BEGIN{d=0} NF==0{d=0} NF>0{if(d)print;d=1}' /home/user/duplicates.txt > /home/user/duplicates.to.delete.txt

Заключение всех строк имен файлов в апострофы (чтобы исключить влияние пробелов в именах для следующей команды rm)

sed "s/\(.*\)/'\1'/" /home/user/duplicates.to.delete.txt  > /home/user/duplicates.to.delete.ok.txt

Удаление файлов повторяющихся более одного раза:

xargs rm < /home/user/duplicates.to.delete.ok.txt


Этой командой производится поиск и удаление (ключ -d) дубликатов без дополнительных подтверждений на удаление (ключ -N) в текущей директории.

fdupes -d -N /home/user/download

#dvd rip
ffmpeg -i concat:VTS_01_1.VOB\|VTS_01_2.VOB\|VTS_01_3.VOB -map 0:v:0 -map 0:a:0 -f mpeg -c copy intermediate.mpeg


#tpcdump

# only sync packets
tcpdump -nnv -i eth0 src 192.168.1.92 and "tcp[13] == 2"
tcpdump -nnvvv -i eth0 src 192.168.1.151 and "tcp[tcpflags] & (tcp-syn|tcp-ack) != 0"

#pdf rotate
gs -sDEVICE=pdfwrite -sOutputFile="out.test" -dNOPAUSE -dEPSCrop -c "<</Orientation 0>> setpagedevice" -f "in.pdf" -c quit


#rename file to hash
for F in *.* ; do echo mv "$F" "$(sha512sum "$F" | cut -d' ' -f1).${F##*.}"; done


#backup_disk with dd and gzip
sudo dd if=/dev/sdX conv=sync,noerror bs=64K | gzip -c | ssh user@local dd of=backup.img.gz
#or
dd if=/dev/sdX conv=sync,noerror bs=64K | gzip -c > backup.img.gz
#or make splits
dd if=/dev/sdX conv=sync,noerror bs=64K | gzip -c | split -a3 -b2G - /path/to/backup.img.gz
#
#RESTORE
gunzip -c /path/to/backup.img.gz | dd of=/dev/sdX
#or connect splits
cat /path/to/backup.img.gz* | gunzip -c | dd of=/dev/sdX

#DDRESQUE
ddrescue -f -n /dev/sdX /dev/sdY rescue.log
 #Second round, copy only the bad blocks and try 3 times to read from the source before giving up.
ddrescue -d -f -r3 /dev/sdX /dev/sdY rescue.log

#Now you can check the file system for corruption and mount the new drive.

 fsck -f /dev/sdY


# asterisk write audio (and convert)

 write
             chanel-v   bytelimit-v      v-stereo-rx-tx-channels
 sudo dahdi_monitor 20 -vv -l 200000000 -s r_test.raw

 converting (8Khz 16bit signed) default asterisk sox parameters
 
 sox -t raw -r 8000 -c 2 -b 16 -e signed FILE.raw FILE.wav

 make spectrogramm
 
 sox "r_test.wav" -n spectrogram -Y 130 -l -r -o "r_test.png"


# выбрать почту email e-mail
grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b"

# массовая рассылка по списку (должны стоять опции set edit_headers=yes) 
#  

for i in `cat listfile.txt`;do cat Email.html | mutt -e "set content_type=text/html" -s "Subject" -F ~/.muttrc-custom -- $i < Email.html ; echo $i ; sleep 3 ; done

# exif renamer
exiftool '-filename<${DateTimeOriginal;tr/ /_/;s/__+/_/g;s/:/-/g}_${Make;tr/ /_/;s/__+/_/g;s/\//-/g}_${Model;tr/ /_/;s/__+/_/g;s/\//-/g;s/,//g}.jpg' ./*
# exif program
for i in *.jpg ; do name=`exif -m --tag=DateTimeOriginal $i`.jpg ; name=`exif -m --tag=Model $i`_$name; name=`exif -m --tag=Make $i`_$name; name=`echo "$name" | sed 's/[ ,:]/-/g'` ; echo mv $i $name ; done


# convert and add watermark\\ mogrify ident 
for i in bktp*.jpg ; do convert $i ../../watermark.png -resize "1024>x768>" -gravity center -composite wm_"$i" ; done

# удаление тумбнейлов, последующее создание их и обрезка под формат и запись в папку с таким же названием по другому пути.
rm t_*.jpg ;for i in wm_*.jpg ; do convert $i -resize "180x135^" -gravity center -crop 180x135+0+0 +repage t_$i ; done ; cp t_* ~/cftp/files/el/worked/2018/`pwd | awk -F / '{print $NF}'

# преобразовать в нижний регистр все имена файлов и папок
for i in * ; do mv "$i" "`echo $i | sed 's/\(\w\)/\l\1/g'`" ; done

#autotrace (centerline)
autotrace -centerline -color-count 2 -output-file /tmp/roma/outputtga.svg -output-format SVG /tmp/roma/scan.tga
