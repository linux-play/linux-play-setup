#!/bin/bash

if test "${LP_ARCHISO}" = 1; then
  cmd='arch-chroot /mnt'
  dir='/mnt'
else
  dir='/'
fi

${cmd} pacman -Syu --noconfirm \
  ${LP_XF86_PKG} \
  abiword \
  arc-gtk-theme \
  arc-icon-theme \
  bluez \
  bluez-utils \
  chromium \
  compton \
  darkhttpd \
  docker \
  docker-compose \
  epdfview \
  feh \
  firefox \
  fish \
  gimp \
  git \
  gnome-themes-extra \
  gnumeric \
  gpicview \
  gtk-engine-murrine \
  gvfs \
  gvfs-mtp \
  i3-gaps \
  i3lock \
  i3status \
  inkscape \
  leafpad \
  maim \
  mariadb-clients \
  mpc \
  mpd \
  mpv \
  ncmpcpp \
  neovim \
  nfs-utils \
  nodejs \
  ntp \
  openssh \
  pamixer \
  pcmanfm \
  pulseaudio \
  pulseaudio-bluetooth \
  rofi \
  rxvt-unicode \
  sylpheed \
  texlive-core \
  texlive-fontsextra \
  texlive-formatsextra \
  texlive-latexextra \
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
  yarn \
  zip

cp -af ./root/. ${dir}

${cmd} timedatectl set-ntp true
${cmd} mkdir -p /home/${LP_USER}
${cmd} git clone --bare https://github.com/linux-play/linux-play-dotfiles.git /home/${LP_USER}/.dotfiles
${cmd} git checkout --git-dir=/home/${LP_USER}/.dotfiles --work-tree=/home/${LP_USER}
${cmd} useradd -d /home/${LP_USER} ${LP_USER}
${cmd} chown -R ${LP_USER} /home/${LP_USER}
${cmd} echo "${LP_USER} ALL=(ALL) ALL" | (EDITOR='tee -a' visudo)