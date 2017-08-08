# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  # Using a preconfigured static address: 192.168.0.199
  config.vm.network "public_network" , bridge: 'en0: Ethernet' #, ip: "192.168.0.198", netmask: "255.255.248.0"
  config.vm.provision :shell, path: "bootstrapelasticsearch.sh"
  config.vm.hostname = "tc-centos-master-elasticsearch-kibana-hatc1"

  # port forwarding
  config.vm.network "forwarded_port", guest: 9200, host: 9201 # ES
  config.vm.network "forwarded_port", guest: 5601, host: 5602 # Kibana
  config.vm.network "forwarded_port", guest: 8111, host: 8112 # HTTP server for test

  config.vm.provider "vmware_fusion" do |v|
      v.memory = 4096
      v.cpus = 2
      v.gui = true
      v.vmx["ethernet0.pcislotnumber"] = "32"
    end

end

# vagrant up --provider vmware_fusion
# vagrant provision

