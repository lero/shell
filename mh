#!/bin/bash
# switch between hi/low dpi
# TODO: sed instead of copy?, telegram scaling, kill urxvtd?, setxkbmap/xset not working

files=~/github/dotfiles

common(){
    # kill apps that will be reloaded
    for x in chromium firefox spotify weechat dunst; do
        pkill $x
    done
    
    # i3
    cp $files/.config/i3/config-$mode ~/.config/i3/config
    i3-msg reload 

    # gtk
    cp $files/.gtkrc-2.0-$mode ~/.gtkrc-2.0
    cp $files/.config/gtk-3.0/settings-$mode.ini ~/.config/gtk-3.0/settings.ini
    
    # xresources
    cp $files/.Xresources-$mode ~/.Xresources
    xrdb -merge ~/.Xresources

    # dunst
    cp $files/.config/dunst/dunstrc-$mode ~/.config/dunst/dunstrc
    dunst &
    
    # chromium
    cp $files/.config/chromium-flags-$mode.conf ~/.config/chromium-flags.conf
    chromium &

    # firefox
    cp $files/.mozilla/firefox/prefs-$mode.js ~/.mozilla/firefox/*.default/prefs.js
    firefox &
    
    # spotify
    if [ $mode == hidpi ]; then
        spotify --force-device-scale-factor=1.5 &
    else
        spotify &
    fi

    # sometimes we lose these settings, so force it
    setxkbmap -variant intl
    xset r rate 350 35
}

export DISPLAY=:0 
export XAUTHORITY=~/.Xauthority

work=$(</sys/class/drm/card0/card0-HDMI-A-1/status)
tv=$(</sys/class/drm/card0/card0-HDMI-A-2/status)
desk1=$(</sys/class/drm/card0/card0-DP-1/status)
desk2=$(</sys/class/drm/card0/card0-DP-2/status)

if [ $work == connected ]; then
    xrandr --output eDP1 --off --output HDMI1 --auto
    mode=lowdpi
elif [ $tv == connected ]; then
    xrandr --output eDP1 --off --output HDMI2 --auto
    mode=lowdpi
elif [ $desk1 == connected ]; then
    xrandr --output eDP1 --off --output DP1 --auto
    mode=lowdpi
elif [ $desk2 == connected ]; then
    xrandr --output eDP1 --off --output DP2 --auto
    mode=lowdpi
else
    xrandr --output eDP1 --auto --output HDMI1 --off --output HDMI2 --off \
        --output DP1 --off --output DP2 --off
    mode=hidpi
fi

common >/dev/null 2>&1
