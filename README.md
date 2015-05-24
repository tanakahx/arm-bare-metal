# arm-bare-metal
Virtual bare metal programming environment for ARM processor

# Environment

Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic x86_64)

# Installation

First of all, it may be required to install the packages `build-essential`, `texinfo`, `libgmp-dev`, `libmpc-dev`, `libmpfr-dev` and so on.(It depends on your development environment.) If it is not installed yet, the following command will do the work.

```console
$ sudo apt-get install build-essential texinfo # for binutils
$ sudo apt-get install libgmp-dev libmpc-dev libmpfr-dev # for GCC
```

## Step 1 - Install binutils

```console
$ wget https://ftp.gnu.org/gnu/binutils/binutils-2.25.tar.bz2
$ tar jxvf binutils-2.25.tar.bz2
$ cd binutils-2.25
$ mkdir build_arm
$ cd build_arm
$ ../configure --prefix=/usr/local/gnu --program-suffix=-arm --target=arm-none-eabi
$ make
$ sudo make install
```

This will install binutils below `/usr/local/gnu`.

## Step 2 - Install GCC

```console
$ wget https://ftp.gnu.org/gnu/gcc/gcc-4.6.4/gcc-core-4.6.4.tar.bz2
$ tar jxvf gcc-core-4.6.4.tar.bz2
$ cd gcc-core-4.6.4
$ mkdir build_arm
$ cd build_arm
$ ../configure --target=arm-none-eabi --disable-nls --disable-threads --disable-shared --disable-libssp --enable-languages=c --prefix=/usr/local/gnu
$ make all-gcc
$ sudo make install-gcc
```

This will install GCC below `/usr/loca/gnu`.

After the installation, Don't forget set PATH environment variable to include the GCC path.

```console
export PATH=/usr/local/gnu/bin:$PATH
```

## Step 3 - Install QEMU

```console
$ sudo apt-get install qemu-system
```

# How to build and run

After binutils and GCC for ARM and QEMU are installed. we can build a program image and run it on a bare metal ARM processor on QEMU. This repository contains a minimal boot code and a linker script, so we can just clone it and run `make` to make the boot image whose name is `image.bin`.

```console
$ git clone https://github.com/tanakahx/arm-versatilepb.git
$ cd arm-versatilepb
$ make
```

`boot.S` is boot code and `main.c` is main code. `boot.S` is set the stack pointer and call `main()` in `main.c`. `main()` uses `puts()` to print out a message.

We can disassemble the image file and check the boot code and code region arrangement.

```consle
$ make dis
```

The boot image can be executed with QEMU like the following.

```console
$ qemu-system-arm -M versatilepb -nographic -kernel image.bin
```

or just

```console
$ make run
```

To exit QEMU, press `C-a x` (`Ctrl + a` and then `x` successively).
