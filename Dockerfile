FROM archlinux/base

MAINTAINER valandil "https://github.com/valandil"

# Install dependencies.
RUN pacman -Syy --noconfirm archlinux-keyring && \
    pacman -S --noconfirm base-devel git && \ 
    pacman -Su --noconfirm

# Prepare notroot user for makepkg.
RUN useradd -m notroot
RUN echo "notroot ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/notroot
USER notroot
WORKDIR /home/notroot

ADD install-mips-xcompiler.sh /home/notroot/install-mips-xcompiler.sh
ADD PKGBUILD.patch /home/notroot/PKGBUILD.patch
RUN sudo chmod +x /home/notroot/install-mips-xcompiler.sh
RUN /home/notroot/install-mips-xcompiler.sh
