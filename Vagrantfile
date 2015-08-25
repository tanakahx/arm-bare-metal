Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    yes Y | sudo -E apt-get install gcc-arm-linux-gnueabi
    yes Y | sudo -E apt-get install git emacs24-nox
    yes Y | sudo -E apt-get install pkg-config g++ libtool zlib1g-dev libglib2.0-dev autoconf flex bison
    if [ ! `which qemu-system-arm` ]; then
      curl -s -O http://wiki.qemu-project.org/download/qemu-2.4.0.tar.bz2 &&
      tar jxvf qemu-2.4.0.tar.bz2 &&
      cd qemu-2.4.0 &&
      ./configure --target-list=arm-softmmu,arm-linux-user &&
      make &&
      sudo make install &&
      cd .. &&
      rm -rf qemu-2.4.0 qemu-2.4.0.tar.bz2
    fi
  SHELL
end
