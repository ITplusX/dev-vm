Vagrant.configure("2") do |config|
	
	config.vm.box = "relativkreativ/centos-7-minimal"
	config.vm.hostname = "dev-vm.local"

	config.ssh.insert_key = false
	
	## Forward ports
	config.vm.network :forwarded_port, guest: 22, host: 22
	config.vm.network :forwarded_port, guest: 80, host: 80

	## Configure virtual box
	config.vm.provider :virtualbox do |vb|
		vb.customize ["modifyvm", :id, "--memory", "2048"]
		vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]
		# Display the gui in case of errors
#		vb.gui = true
	end
	
#	# Run the provisioning - we have to do that manually :-(
#	config.vm.provision :shell do |shell|
#		shell.path = "conf/srv/provision.sh"
#	end
#	
#	# Run a script after vm is up
#	config.vm.provision "shell", path: "conf/srv/afterboot.sh", run: "always"
end
