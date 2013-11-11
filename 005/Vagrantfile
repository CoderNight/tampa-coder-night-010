
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	config.vm.hostname = "chess"
	config.vm.provider :virtualbox do |vb|
		vb.customize ["modifyvm", :id, "--name", "chess", "--memory", "512"]
  end
  config.vm.box = "lucid64_final"
  config.vm.network :forwarded_port, guest: 80, host: 4567
  config.vm.network :forwarded_port, guest: 3000, host: 3000
	config.vm.network :private_network, ip: "33.33.13.37"
  # config.vm.synced_folder  "../../lincoln_rails_ops",  "/etc/puppet"
end
