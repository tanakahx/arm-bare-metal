Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision "shell", inline: <<-SHELL
    yes Y | sudo -E apt-get install gcc-arm-linux-gnueabi qemu-system git emacs24-nox
  SHELL
end
