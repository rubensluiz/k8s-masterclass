# -*- mode: ruby -*-
# vi:set ft=ruby sw=2 ts=2 sts=2:

# Define the number of master and worker nodes

NUM_MASTER_NODE = 1
NUM_WORKER_NODE = 2

IP_NW = "192.168.57."
MASTER_IP_START = 1
NODE_IP_START = 2
LB_IP_START = 30

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.box_check_update = false

  # Provision Master Nodes
  (1..NUM_MASTER_NODE).each do |i|
      config.vm.define "kmaster0#{i}" do |node|
        # Name shown in the GUI
        node.vm.provider "virtualbox" do |vb|
            vb.name = "kmaster0#{i}"
            vb.memory = 2048
            vb.cpus = 2
        end
        node.vm.hostname = "kmaster0#{i}"
        node.vm.network :private_network, ip: IP_NW + "#{MASTER_IP_START + i}"
      end
      config.vm.provision "shell", path: "common.sh"
  end


  # Provision Worker Nodes
  (1..NUM_WORKER_NODE).each do |i|
    config.vm.define "kworker0#{i}" do |node|
        node.vm.provider "virtualbox" do |vb|
            vb.name = "kworker0#{i}"
            vb.memory = 2048
            vb.cpus = 2
        end
        node.vm.hostname = "kworker0#{i}"
        node.vm.network :private_network, ip: IP_NW + "#{NODE_IP_START + i}"
    end
  end
  config.vm.provision "shell", path: "common.sh"
end
