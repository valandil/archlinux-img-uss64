#!/bin/bash
# --------------------------------------------------------------------------- #
# Author:        Joey Dumont         <joey.dumont@gmail.com>                  #
# Date:          2019-01-25                                                   #
# Decsription:   Insructions to compile the mips64-elf-gcc cross-compiler on  #
#                an Arch Linux Docker image.                                  #
# --------------------------------------------------------------------------- #

# -- Install mips64-elf-binutils
git clone https://aur.archlinux.org/mips64-elf-binutils.git
cd mips64-elf-binutils
makepkg --noconfirm -sic
cd ../

# -- Install mips64-elf-gcc-stage1
git clone https://aur.archlinux.org/mips64-elf-gcc-stage1.git
cd mips64-elf-gcc-stage1
makepkg --noconfirm  -sic
cd ../

# -- Install mips64-elf-newlib
git clone https://aur.archlinux.org/mips64-elf-newlib.git
cd mips64-elf-newlib
makepkg --noconfirm -sic
cd ../

# -- Finally install mips64-elf-gcc
git clone https://aur.archlinux.org/mips64-elf-gcc.git
cd mips64-elf-gcc
makepkg --noconfirm -sic
cd ../
