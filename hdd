#!/bin/sh


HDD_UUID=68ad716c-31f7-4d05-98dc-3430dda7e7f0
HDD_MP=/mnt/storage0/

MAPPED_NAME=crypthdd
VG_NAME=hdd
LV_NAME=data-0


function help()
{
  echo "hdd: no/invalid command specified. aborting..."
  echo "usage: hdd <command>"
  echo ""
  echo "COMMANDS:"
  echo "  open  - decrypts, activates and mounts /dev/$VG_NAME/$LV_NAME"
  echo "  close - umnounts, deactivates and encrypts /dev/$VG_NAME/$LV_NAME"
}


echo ""

if [ "$#" == "0" ]
then
  help
fi

if [ "$1" == "open" ]
then
  echo "attempting to open /dev/$VG_NAME/$LV_NAME..."
  if [ -e /dev/disk/by-uuid/$HDD_UUID ]
  then
    sudo cryptsetup luksOpen /dev/disk/by-uuid/$HDD_UUID $MAPPED_NAME --key-file /boot/volume.key && echo "HDD decrypted." &&
      sudo vgchange -q -ay $VG_NAME && 
    if [ -d $HDD_MP ]
    then
      sudo mount -v /dev/$VG_NAME/$LV_NAME $HDD_MP
    else
      echo ""
    fi
  fi
elif [ "$1" == "close" ]
then
  echo "attempting to close /dev/$VG_NAME/$LV_NAME..."
  sudo umount -v /dev/$VG_NAME/$LV_NAME &&
  sudo vgchange -an $VG_NAME &&
  sudo cryptsetup close /dev/mapper/$MAPPED_NAME && echo "HDD encrypted."
else
  help
fi 

echo ""
