FROM archlinux/base

MAINTAINER valandil "https://github.com/valandil"

# Install dependencies.
RUN pacman -Syy --noconfirm archlinux-keyring && \
    pacman -S --noconfirm base-devel && \ 
    pacman -Su --noconfirm

# Prepare notroot user for makepkg.
RUN useradd -m notroot
RUN echo "notroot ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/notroot
USER notroot
WORKDIR /home/notroot

ADD install-mips-xcompiler.sh install-mips-xcompiler.sh
RUN sudo chmod +x install-mips-xcompiler.sh
RUN install-mips-xcompiler.sh
