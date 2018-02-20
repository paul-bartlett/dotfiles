setxkbmap dvorak
xrdb ~/.Xresources

exec nm-applet &
exec udiskie -t &
exec start-pulseaudio-x11 &

exec ck-launch-session i3
