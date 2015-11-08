Vagrant.configure(2) do |config|
  config.vm.box = "chef/fedora-23"
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provision.yml"
  end
end
