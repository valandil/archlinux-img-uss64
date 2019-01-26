FROM archlinux/base

MAINTAINER valandil "https://github.com/valandil"

# Install dependencies.
RUN pacman -S base-devel

ADD install-mips-xcompiler.sh /install-mips-xcompiler.sh
RUN chmod +x /install-mips-xcompiler.sh
RUN /install-mips-xcompiler.sh
