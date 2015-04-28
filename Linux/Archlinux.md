## ArchLinux

### install

- https://wiki.archlinux.org/index.php/Beginners%27_guide_%28%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87%29
- https://hyjk2000.github.io/2014/01/23/arch-linux-install-guide/

1. 要确认是否已进入UEFI模式，可运行： `# efivar -l`
2. 建立网络连接 `# ping -c 1 t.cn` (会自动 DHCP)
    - 否则要 `ip link` 然后在 `/etc/dhcpcd.conf` 中设置静态dhcpcd
    - 无线： `# iw dev# + wifi-menu`
3. 识别设备 `# lsblk`
4. 分区
    - 判断 `# parted /dev/sdx print (MBR/msdos or GPT/gpt)`
    - 分区工具：`parted` or `fdisk`
    - parted
        + 打开需要新建分区表的设备：`# parted /dev/sdx`
        + `(parted) print` 看分区表
        + ！创建分区表： `(parted) mklabel msdos(or gpt)`
        + 分区：`(parted) mkpart part-type fs-type start end`
        + 设置 /boot 为启动目录：`(parted) set partition-num boot on`
    - fdisk
        + 打开：`# fdisk /dev/sda`
        + `p` 看分区表
        + ！创建分区表：`o`
        + 分区：`n` 然后配置
    - 固态硬盘可以检查，如果返回值为0，则分区已经对齐： `# blockdev --getalignoff /dev/<partition>`
    - 创建文件系统
        + 先查看所有分区： `# lsblk /dev/sdx`
        + 格式化：`# mkfs.ext4 /dev/sdxY`
        + 格式化并启用 swap 区：`# mkswap /dev/sdaX ` and `# swapon /dev/sdaX`
    - 挂载分区
        + 先挂载 / (root) 分区：`# mount /dev/sdxR /mnt`
        + 然后挂载其余单独分区：`# mount /dev/sda2 /mnt/home`
5. 选择安装镜像
    - 编辑 `/etc/pacman.d/mirrorlist`，在前面加上：` Server = http://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch`
6. 安装基本系统：`# pacstrap -i /mnt base base-devel`
7. 生成 fstab
    - `# genfstab -U -p /mnt >> /mnt/etc/fstab`
    - 检查一下：`# vi /mnt/etc/fstab`
8. 配置新系统
    - chroot 到新系统：`# arch-chroot /mnt /bin/bash`
    - 语言地区：编辑 `/etc/locale.gen` 去掉以下项目的注释 `en_US.UTF-8 UTF-8 zh_CN.UTF-8 UTF-8 zh_TW.UTF-8 UTF-8`
    - 执行 `locale-gen`
    - 将系统 locale 设置为 `en_US.UTF-8`：`# echo LANG=en_US.UTF-8 > /etc/locale.conf`
    - 时区：
        + 查看时区：`# ls /usr/share/zoneinfo/`
        + 软链接设置 localtime：`# ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime`
    - 时间：
        + 设置系统时间： `# date -s "Jan 23, 2014 12:23:04"`
        + 利用 ntp 自动校时：`# pacman -S ntp` and `ntpdate time.nist.gov`
        + 将系统时间写入硬件时钟：`# hwclock --systohc --utc`
        + ！此时强烈建议将 Windows 设置成 UTC 时间，并停止自动时间调整。
    - 主机名：`# echo illuz-arch > /etc/hostname`，并在 /etc/hosts 添加同样的主机名
    - 连接网络：`# systemctl enable dhcpcd.service`（装 Gnome 要换成 NetworkManager）
    - 安装和配置 Bootloader：
        + BIOS：`# pacman -S grub os-prober` `# grub-install --target=i386-pc --recheck /dev/sda` `# grub-mkconfig -o /boot/grub/grub.cfg`
        + UEFI：`# mount -t efivarfs efivarfs /sys/firmware/efi/efivars` `# pacman -S grub os-prober efibootmgr` `# grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch_grub --recheck` `# grub-mkconfig -o /boot/grub/grub.cfg`
    - 卸载分区并重启系统：`# exit` `# umount -R /mnt` `# reboot`
9. 系统管理
    - 用户：`# useradd -m -d -g users -G wheel -s /usr/bin/zsh illuz`
    - 密码：`passwd illuz`

*(Updating)*
