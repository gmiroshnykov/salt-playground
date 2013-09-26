# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  # config.vm.box_url = "http://files.vagrantup.com/precise64_vmware_fusion.box"

  config.vm.hostname = "salt-playground.dev"
  config.vm.network :private_network, ip: "10.0.9.2"
  config.vm.synced_folder ".", "/opt/salt-playground", :nfs => true
  config.vm.synced_folder "salt/state", "/srv/salt"
  config.vm.synced_folder "salt/pillar", "/srv/pillar"

  config.ssh.forward_agent = true

  cpus = 2
  memory = ENV["MEMORY"] ? ENV["MEMORY"] : "512"

  config.vm.provider :virtualbox do |vb|
    vb.gui = true if ENV["DEBUG"]
    vb.customize ["modifyvm", :id, "--memory", memory]
    vb.customize ["modifyvm", :id, "--cpus", cpus]
  end

  config.vm.provider :vmware_fusion do |v|
    v.gui = true if ENV["DEBUG"]
    v.vmx["memsize"] = memory
    v.vmx["numvcpus"] = cpus
  end

  config.vm.provision "shell", inline: "wget -O - http://bootstrap.saltstack.org | sudo sh"

  if defined? VagrantPlugins::Cachier
    config.cache.auto_detect = true
  end
end
