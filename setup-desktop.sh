#!/bin/bash

if test "${LP_ARCHISO}" = 1; then
  cmd='arch-chroot /mnt'
  dir='/mnt'
else
  dir='/'
fi

${cmd} pacman -Syu --noconfirm \
  ${LP_XF86_PKG} \
  arc-gtk-theme \
  arc-icon-theme \
  chromium \
  compton \
  epdfview \
  feh \
  fish \
  git \
  gnome-themes-extra \
  gpicview \
  gtk-engine-murrine \
  gvfs \
  i3-gaps \
  i3lock \
  i3status \
  leafpad \
  maim \
  mpc \
  mpv \
  ncmpcpp \
  neovim \
  ntp \
  openssh \
  pamixer \
  pcmanfm \
  pulseaudio \
  rofi \
  rxvt-unicode \
  sylpheed \
  ttf-dejavu \
  ttf-droid \
  ttf-inconsolata \
  ttf-roboto \
  ttf-ubuntu-font-family \
  unrar \
  unzip \
  xarchiver \
  xcursor-vanilla-dmz \
  xorg-server \
  xorg-xinit \
  xorg-xrandr \
  zip

cp -af ./root/. ${dir}

${cmd} timedatectl set-ntp true
${cmd} mkdir -p /home/${LP_USER}
${cmd} git clone --bare https://github.com/linux-play/linux-play-dotfiles.git /home/${LP_USER}/.dotfiles
${cmd} git --git-dir=/home/${LP_USER}/.dotfiles --work-tree=/home/${LP_USER} checkout
${cmd} useradd -d /home/${LP_USER} ${LP_USER}
${cmd} chown -R ${LP_USER} /home/${LP_USER}
${cmd} echo "${LP_USER} ALL=(ALL) ALL" | (EDITOR='tee -a' visudo)