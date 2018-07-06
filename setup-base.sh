#!/bin/bash

if test "${LP_ARCHISO}" != 1; then
  exit 0
fi

timedatectl set-ntp true
hwclock --systohc

(
  echo "o"
  echo "n"
  echo
  echo
  echo
  echo "+1G"
  echo "a"
  echo "n"
  echo
  echo
  echo
  echo
  echo "w"
) | fdisk ${LP_DEVICE}
mkfs.ext4 -F ${LP_DEVICE}1
mkfs.ext4 -F ${LP_DEVICE}2
mount -o defaults,noatime ${LP_DEVICE}2 /mnt
mkdir /mnt/boot
mount -o defaults,noatime ${LP_DEVICE}1 /mnt/boot

sed -i "1 i\Server = ${LP_MIRROR}\n" /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel grub

genfstab -L /mnt > /mnt/etc/fstab
echo -n "${LP_HOSTNAME}" > /mnt/etc/hostname
echo -n "LANG=${LP_LANG}" > /mnt/etc/locale.conf
echo -en "${LP_LANG} $(echo ${LP_LANG} | cut -d '.' -f 2)\nen_US.UTF-8 UTF-8" > /mnt/etc/locale.gen
echo -n "KEYMAP=${LP_KEYMAP}" > /mnt/etc/vconsole.conf
arch-chroot /mnt ln -fs /usr/share/zoneinfo/${LP_TIMEZONE} /etc/localtime
arch-chroot /mnt locale-gen
arch-chroot /mnt mkinitcpio -p linux
arch-chroot /mnt grub-install ${LP_DEVICE}
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
arch-chroot /mnt systemctl enable dhcpcd

umount -R /mnt