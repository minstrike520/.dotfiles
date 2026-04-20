#!/bin/bash

# 中止所有舊行程
killall -9 termux-x11 pulseaudio virgl_test_server_android termux-wake-lock

rm /data/data/com.termux/files/usr/tmp/dbus-*

# 啟動Termux X11
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity
XDG_RUNTIME_DIR=${TMPDIR}
termux-x11 :0 -ac &
sleep 3

# 啟動PulseAudio
pulseaudio --start --exit-idle-time=-1
pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1

# 啟動GPU加速的virglserver
virgl_test_server_android &

# 登入proot Arch Linux，並啟動PulseAudio、Fcitx5、桌面環境
proot-distro login archlinux --user bladeisoe --termux-home --shared-tmp -- bash -c "export DISPLAY=:0 PULSE_SERVER=tcp:127.0.0.1; dbus-launch --exit-with-session startplasma-x11"
