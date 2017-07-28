
#/usr/bin
#

gs -sDEVICE=pdfwrite -sOutputFile="rot_$1" -dNOPAUSE -dEPSCrop -c "<</Orientation 0>> setpagedevice" -f "$1" -c quit
