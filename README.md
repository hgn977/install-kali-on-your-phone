# 手机安装kali
### Termux基础设置
获取存储权限
```
termux-setup-storage
```
切换清华源
```
termux-change-repo
```
更新软件源
```
pkg update && pkg upgrade
```
安装基础软件
```
pkg install x11-repo
```
```
pkg install termux-x11-nightly pulseaudio wget
```
### 安装kali
```
wget -O install-nethunter-termux https://offs.ec/2MceZWr
```
添加运行权限
```
chmod +x install-nethunter-termux
```
运行安装脚本
```
./install-nethunter-termux
```
kali启动命令
<table>
  <tr><td>nethunter</td><td>启动NetHunter命令行</td></tr>
  <tr><td>nethunter kex passwd</td><td>设置Kex密码</td></tr>
  <tr><td>nethunter kex &</td><td>启动NetHunter GUI</td></tr>
  <tr><td>nethunter kex stop</td><td>停止NetHunter GUI</td></tr>
  <tr><td>nethunter -r</td><td>以root用户运行NetHunter</td></tr>
  <tr><td>nh</td><td>Nethunter的快捷方式</td></tr>
</table>

更换清华源
```
sed -i "s@http://http.kali.org/kali@https://mirrors.tuna.tsinghua.edu.cn/kali@g" /etc/apt/sources.list
```
更新软件源
```
sudo apt update && sudo apt upgrade -y
```
安装postgresql-17报错处理
```
sudo dpkg --configure -a
```
```
sudo apt autoclean
```
```
printf '%s\n' '#!/bin/sh' 'exit 0' | sudo tee /var/lib/dpkg/info/postgresql-17.prerm >/dev/null
```
### 设置中文
```
sudo apt install -y fonts-noto-cjk fonts-wqy-zenhei fonts-wqy-microhei
```
```
sudo dpkg-reconfigure locales
```
退出至termux环境
```
nano $PREFIX/bin/nh
```
```
LANG=zh_CN.UTF-8
```
火狐浏览器中文语言包
```
sudo apt install firefox-esr-l10n-zh-cn
```
### 设置时区
```
sudo dpkg-reconfigure tzdata
```
### 启动图形桌面

#### VNC
因为鸿蒙系统对权限控制严格无法使用termux：x11,所以使用vnc

设置vnc密码
```
nethunter kex passwd
```
启动vnc
```
nethunter kex & 
```
```
127.0.0.1:5901
```
停止vnc
```
nethunter kex stop
```
#### Termux:X11
除鸿蒙系统外其他安卓可使用Termux:X11

打开kali启动脚本
```
nano $PREFIX/bin/nh
```
```
-b /data/data/com.termux/files/usr/tmp:/tmp \
```
下载启动脚本
```
wget https://gitee.com/hgn977/install-kali-on-your-phone/raw/master/kali/nethunter_xfce4.sh
```
```
chmod +x nethunter_xfce4.sh
```
```
./nethunter_xfce4.sh
```
