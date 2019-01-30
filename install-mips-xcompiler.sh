#!/bin/bash
# --------------------------------------------------------------------------- #
# Author:        Joey Dumont         <joey.dumont@gmail.com>                  #
# Date:          2019-01-25                                                   #
# Decsription:   Insructions to compile the mips64-elf-gcc cross-compiler on  #
#                an Arch Linux Docker image.                                  #
# --------------------------------------------------------------------------- #

# -- Fails the script when a command fails.
set -e 

# -- Bucket that holds the package sources.
BUCKET_URL='https:\/\/s3.amazonaws.com\/archlinux-n64-packages\/'


# -- Function to replace the source of each PKGBUILD.
# --    $1: Name of file in S3 bucket.
# --    $2: Path of file.
function ReplaceSourceWithS3()
{
    perl -i.bak -pe 's/(?<=source=\()[^\s\)]+/'"${BUCKET_URL}$1"'/; print $1;' $2
}

# -- Install mips64-elf-binutils
git clone https://aur.archlinux.org/mips64-elf-binutils.git
cd mips64-elf-binutils
ReplaceSourceWithS3 'binutils-\${pkgver}.tar.xz' PKGBUILD
makepkg --noconfirm -sic > makepkg.log 2>&1
cd ../

# -- Install mips64-elf-gcc-stage1
git clone https://aur.archlinux.org/mips64-elf-gcc-stage1.git
cd mips64-elf-gcc-stage1
makepkg --noconfirm  -sic > makepkg.log 2>&1
cd ../

# -- Install mips64-elf-newlib
git clone https://aur.archlinux.org/mips64-elf-newlib.git
cd mips64-elf-newlib
ReplaceSourceWithS3 'newlib-\${pkgver}.tar.gz' PKGBUILD
makepkg --noconfirm -sic > makepkg.log 2>&1
cd ../

# -- Finally install mips64-elf-gcc
sudo pacman -R --nodeps --nodeps --noconfirm mips64-elf-gcc
git clone https://aur.archlinux.org/mips64-elf-gcc.git
cd mips64-elf-gcc
makepkg --noconfirm -sic
cd ../
