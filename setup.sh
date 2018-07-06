#!/bin/bash

echo "     __    __                    ____  __            "
echo "    / /   /_/___  __  ___  __   / __ \/ /_______  __ "
echo "   / /   / / __ \/ / / / |/_/  / /_/ / / __  / / / / "
echo "  / /___/ / / / / /_/ />  <   / ____/ / /_/ / /_/ /  "
echo " /_____/_/_/ /_/\____/_/|_|  /_/   /_/\____/\__  /   "
echo "                                           /____/    "

params=(
  LP_DEVICE   '/dev/sda'
  LP_HOSTNAME 'virtual'
  LP_KEYMAP   'de-latin1-nodeadkeys'
  LP_LANG     'en_DK.UTF-8'
  LP_MIRROR   'https://ftp.fau.de/archlinux/\$repo/os/\$arch'
  LP_TIMEZONE 'Europe/Berlin'
  LP_USER     'user'
)

function confirm {
  read input
  if test "${input}" != 'y'; then
    exit 1
  fi
}

function echo_params {
  let i=0
  while test ${i} -lt ${#params[@]}; do
    local -n param=${params[i]}
    printf '%-13s' "* ${params[i]}"
    echo " = ${param}"
    let i=i+2
  done
}

function exec_scripts {
  for script in $(ls ./setup-*.sh); do
    ${script}
  done
}

function init_params {
  let i=0
  while test ${i} -lt ${#params[@]}; do
    local -n param=${params[i]}
    if test -z ${param}; then
      printf "* ${params[i]} (${params[i+1]}): "
      read input
      param=${input:-${params[i+1]}}
    fi
    let i=i+2
  done
}

function pass_params {
  let i=0
  while test ${i} -lt ${#params[@]}; do
    export ${params[i]}
    let i=i+2
  done
  if test "${HOSTNAME}" = 'archiso' -a "${USER}" = 'root'; then
    export LP_ARCHISO=1
  fi
}

echo
echo "Enter parameters"
init_params

echo
echo "Using parameters"
echo_params

echo
printf "Proceed (y/n): "
confirm

echo
echo "Starting setup"
pass_params
exec_scripts