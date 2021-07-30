FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /opt

RUN apt-get update && apt-get install -y curl build-essential texinfo libgmp-dev libmpc-dev libmpfr-dev qemu-system-arm

RUN curl -O https://ftp.gnu.org/gnu/binutils/binutils-2.37.tar.xz && \
    tar Jxvf binutils-2.37.tar.xz && \
    cd binutils-2.37 && \
    mkdir build_arm && \
    cd build_arm && \
    ../configure --program-suffix=-arm --target=arm-none-eabi && \
    make -j`nproc` && \
    make install && \
    cd ../.. && \
    rm -rf binutils-2.37*

RUN curl -O https://ftp.gnu.org/gnu/gcc/gcc-9.4.0/gcc-9.4.0.tar.xz && \
    tar Jxvf gcc-9.4.0.tar.xz && \
    cd gcc-9.4.0 && \
    mkdir build_arm && \
    cd build_arm && \
    ../configure --target=arm-none-eabi --disable-nls --disable-threads --disable-shared --disable-libssp --enable-languages=c && \
    make -j`nproc` all-gcc && \
    make install-gcc && \
    cd ../.. && \
    rm -rf gcc-9.4.0*


