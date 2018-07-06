#!/bin/bash

if test "${LP_ARCHISO}" != 1; then
  exit 0
fi

umount -R /mnt