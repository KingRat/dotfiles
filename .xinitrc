#!/bin/bash
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
xset b off
bgd(){
   pidof $1 >& /dev/null
   if [ $? -ne 0 ]; then
       $@ &
   fi
}

bgd urxvtd
bgd fluxgui
bgd compton -cfD3 -r10 -i.9 -o.4
bgd mpdscribble

xrdb ~/.Xresources
xrdb -merge ~/.colours/dogs

DEFAULT_SESSON=exec /usr/bin/awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr

case $1 in
xfce4)
    exec startxfce4
    ;;
dwm)
    exec dwm
    ;;
rio)
    exec rio
    ;;
i3)
    exec i3
    ;;
wmfs)
    exec wmfs
    ;;
*)
    exec $DEFAULT_SESSION
    ;;
esac
