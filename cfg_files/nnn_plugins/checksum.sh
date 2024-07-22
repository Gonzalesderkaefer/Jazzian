#!/bin/sh

echo $1
echo $2

f=$2/$1


echo "Please enter the checksum: "
read checksum


echo "Please choose the Algorithm"
echo "[1] SHA256"
echo "[2] SHA512"
echo "[3] MD5"
echo "[4] SHA384"
echo "[5] SHA224"
echo "[6] SHA1"
read sha
    case $sha in
        "1") [ "$(sha256sum $f | awk '{print $1}')" = "$checksum" ] && echo -e "Checksum is \033[01;32mOK\033[00m." || echo -e "Checksum is\033[0;31m NOT OK\033[0m.";;
        "2") [ "$(sha512sum $f | awk '{print $1}')" = "$checksum" ] && echo -e "Checksum is \033[01;32mOK\033[00m." || echo -e "Checksum is\033[0;31m NOT OK\033[0m.";;
        "3") [ "$(md5sum $f | awk '{print $1}')" = "$checksum" ] && echo -e "Checksum is \033[01;32mOK\033[00m." || echo -e "Checksum is\033[0;31m NOT OK\033[0m.";;
        "4") [ "$(sha384sum $f | awk '{print $1}')" = "$checksum" ] && echo -e "Checksum is \033[01;32mOK\033[00m." || echo -e "Checksum is\033[0;31m NOT OK\033[0m.";;
        "5") [ "$(sha224sum $f | awk '{print $1}')" = "$checksum" ] && echo -e "Checksum is \033[01;32mOK\033[00m." || echo -e "Checksum is\033[0;31m NOT OK\033[0m.";;
        "6") [ "$(sha1sum $f | awk '{print $1}')" = "$checksum" ] && echo -e "Checksum is \033[01;32mOK\033[00m." || echo -e "Checksum is \033[0;31m NOT OK\033[0m.";;
    esac
    echo "Press Enter to continue."
    read p
