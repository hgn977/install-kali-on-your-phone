# 手机安装kali
所需软件
- [Termux](https://github.com/hgn977/install-kali-on-your-phone/releases/download/v0.1/termux-app_v0.118.3+github-debug_arm64-v8a.apk)
- [Termux: X11](https://github.com/hgn977/install-kali-on-your-phone/releases/download/v0.1/app-arm64-v8a-debug.apk)
- [VNC](https://github.com/hgn977/install-kali-on-your-phone/releases/download/v0.1/com.realvnc.viewer.android.apk)



### Termux基础设置
获取存储权限
```
termux-setup-storage
```
<!-- 切换清华源
```
termux-change-repo
``` -->
更新软件源
```
pkg update && pkg upgrade
```
安装基础软件
```
pkg install x11-repo
```
```
pkg install termux-x11-nightly pulseaudio wget android-tools
```
<!-- ### 下载kali安装包
> 编号：1 (full)
> ```
> wget https://kali.download/nethunter-images/kali-2025.4/rootfs/kali-nethunter-rootfs-full-arm64.tar.xz
> ```
> 编号：3 (nano)
> ```
> wget https://kali.download/nethunter-images/kali-2025.4/rootfs/kali-nethunter-rootfs-nano-arm64.tar.xz
> ``` -->
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

进入kali系统
```
nh
```

更换清华源
```
sed -i "s@http://http.kali.org/kali@https://mirrors.tuna.tsinghua.edu.cn/kali@g" /etc/apt/sources.list
```
解决无法联网问题
```
cat > /etc/resolv.conf << EOF
nameserver 1.1.1.1
nameserver 1.0.0.1
nameserver 8.8.8.8
EOF
```
锁定systemd
```
sudo apt-mark hold libsystemd0 systemd udev libsystemd-shared libudev1 systemd-sysv
```
更新软件源
```
sudo apt update && sudo apt upgrade -y
```
安装postgresql-18报错处理  (**如无此报错请直接忽略**)
```
sudo dpkg --configure -a
```
```
sudo apt autoclean
```
```
printf '%s\n' '#!/bin/sh' 'exit 0' | sudo tee /var/lib/dpkg/info/postgresql-18.prerm >/dev/null
```
```
sudo apt update && sudo apt upgrade -y
```
<!-- ### 安装工具集合
```
sudo apt install kali-linux-default kali-linux-everything
``` -->
### 安装桌面
> KDE桌面 
> ```
> sudo apt install kali-desktop-kde
> ```
> e17桌面
> ```
> sudo apt install kali-desktop-e17
> ```

### 设置时区
```
sudo dpkg-reconfigure tzdata
```
### 启动图形桌面

#### VNC
- 因为鸿蒙系统对权限控制严格无法使用termux：x11,所以使用vnc

进入kali系统
```
nh
```
编辑VNC启动文件
```
sudo nano /etc/X11/Xtigervnc-session
```
修改启动桌面
> KDE桌面 
> ```
> exec startplasma-x11
> ```
> e17桌面
> ```
> exec enlightenment_start
> ```
保存更改
```
Ctrl+S 保存
Ctrl+X 退出
```
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
- 除鸿蒙系统外其他安卓可使用Termux:X11

打开kali启动脚本
```
nano $PREFIX/bin/nh
```
```
-b /data/data/com.termux/files/usr/tmp:/tmp \
```
下载启动脚本
> e17桌面
> ```
> wget https://raw.githubusercontent.com/hgn977/install-kali-on-your-phone/refs/heads/main/kali/nethunter_e17.sh
> ```
> KDE桌面
> ```
> wget https://raw.githubusercontent.com/hgn977/install-kali-on-your-phone/refs/heads/main/kali/nethunter_kde.sh
> ```

```
chmod +x nethunter_e17.sh
```
```
./nethunter_e17.sh
```
### 安装谷歌浏览器
```
sudo apt install chromium chromium-l10n
```
启动谷歌浏览器
```
chromium --no-sandbox --password-store=basic
```
`--no-sandbox`表示禁用沙盒，在容器里安装的无法使用沙盒

`--password-store=basic`表示禁止设置密码

### 设置中文
```
sudo apt install -y fonts-noto-cjk fonts-wqy-zenhei fonts-wqy-microhei
```
```
sudo dpkg-reconfigure locales
```
退出至termux环境
```
exit
```
```
nano $PREFIX/bin/nh
```
```
LANG=zh_CN.UTF-8
```
<!-- 火狐浏览器中文语言包
```
sudo apt install firefox-esr-l10n-zh-cn
``` -->
