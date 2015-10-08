#
#  !!!!THIS IS NO SCRIPT FILE!!!
#
#
# just compile of bash one-string useful commands 



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
