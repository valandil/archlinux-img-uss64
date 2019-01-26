#!/bin/bash
# --------------------------------------------------------------------------- #
# Author:        Joey Dumont         <joey.dumont@gmail.com>                  #
# Date:          2019-01-25                                                   #
# Decsription:   Insructions to compile the mips64-elf-gcc cross-compiler on  #
#                an Arch Linux Docker image.                                  #
# --------------------------------------------------------------------------- #

# -- Fails the script when a command fails.
set -e 

# -- Install mips64-elf-binutils
git clone https://aur.archlinux.org/mips64-elf-binutils.git
cd mips64-elf-binutils
patch -i ../PKGBUILD.patch 
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
makepkg --noconfirm -sic > makepkg.log 2>&1
cd ../

# -- Finally install mips64-elf-gcc
git clone https://aur.archlinux.org/mips64-elf-gcc.git
cd mips64-elf-gcc
makepkg --noconfirm -sic > makepkg.log 2>&1
cd ../
