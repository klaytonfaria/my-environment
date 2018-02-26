Vagrant.configure("2") do |config|
  config.vm.box = "jhcook/macos-sierra"
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
  end
  config.vm.provider "virtualbox" do |v|
    v.name = "mac-setup"
  end

end