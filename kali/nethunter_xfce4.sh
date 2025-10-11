#!/data/data/com.termux/files/usr/bin/bash
set -e

# 杀掉旧的 termux-x11（容错）
pkill -f termux.x11 2>/dev/null || true

# 启动 pulseaudio（使用 TCP module 供容器连接）
pulseaudio --kill 2>/dev/null || true
pulseaudio --start --exit-idle-time=-1

pactl load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1 port=4713 2>/dev/null || true

xhost +local: 2>/dev/null || true


export XDG_RUNTIME_DIR=${TMPDIR}
termux-x11 :0 >/dev/null &

sleep 2
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity >/dev/null 2>&1
sleep 1


nethunter -r 'su - kali -c "export DISPLAY=:0; export PULSE_SERVER=tcp:127.0.0.1:4713; export XDG_RUNTIME_DIR='"${TMPDIR}"'; exec startxfce4"' || true

exit 0
