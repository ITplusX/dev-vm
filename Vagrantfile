Vagrant.configure("2") do |config|
	
	config.vm.box = "relativkreativ/centos-7-minimal"
	config.vm.hostname = "dev-vm.local"

	config.ssh.insert_key = false
	
	## Forward ports
	config.vm.network :forwarded_port, guest: 80, host: 80
	config.vm.network :forwarded_port, guest: 3306, host: 3306
	config.vm.network :forwarded_port, guest: 22, host: 22

	## Configure virtual box
	config.vm.provider :virtualbox do |vb|
		vb.customize ["modifyvm", :id, "--memory", "2048"]
		vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]
	end
	
	config.vm.provision :shell do |shell|
		shell.path = "conf/srv/provision.sh"
	end	
end
