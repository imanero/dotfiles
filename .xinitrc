#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Mouse
xinput --set-prop 9 "libinput Accel Speed" -0.5

# Monitor
xrandr --output DP-0 --mode 1920x1080 --rate 144

# Screen blackout
xset -dpms
xset s off

# Keyboard layout
setxkbmap -option grp:alt_shift_toggle us,ir

# Envirounment variables

# Background image
feh --bg-scale ~/Photos/green.jpg

# Startup porgrams
picom &
pipewire &
wireplumber &
polybar main &
exec awesome

