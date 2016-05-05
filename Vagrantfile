# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "debian/wheezy64"

  config.vm.network "forwarded_port", guest: 8085, host: 8085
  config.vm.network "forwarded_port", guest: 3724, host: 3724

  config.vm.synced_folder '.', '/vagrant', type: 'rsync'

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = "4"
    vb.memory = "4096"
  end

  config.vm.provision "dependencies", type: :shell, path: "bootstrap_dependencies.sh"
  config.vm.provision "data", type: :shell, path: "bootstrap_data.sh"
  config.vm.provision "database_create", type: :shell, path: "bootstrap_database_create.sh"
  config.vm.provision "database_update", run: :always, type: :shell, path: "bootstrap_database_update.sh"
  config.vm.provision "build", run: :always, type: :shell, path: "bootstrap_build.sh"
end
