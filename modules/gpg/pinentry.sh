#!/bin/sh

echo "OK its time to enter ur password or something"

while read stdin; do
  case $stdin in
    *BYE*) exit 0 ;;
    *SETDESC*) KEYNAME=''${stdin#*:%0A%22}; KEYNAME=''${KEYNAME%\%22\%0A*}; KEYID=''${stdin#*ID }; KEYID=''${KEYID%,*}; echo OK ;;
    *GETPIN*) echo "D `fuzzel --dmenu --password=• -l 0 --layer=overlay --width=100 --anchor=top --font=monospace --prompt="password for ''${KEYNAME} > "`"; echo OK;;
    *SETERROR*) notify-send "''${stdin#SETERROR }"; echo "OK" ;;
    *) echo OK;;
  esac
done
