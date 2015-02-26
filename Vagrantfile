Vagrant.configure("2") do |config|
	
	config.vm.box = "relativkreativ/centos-7-minimal"
	config.vm.hostname = "dev.local"
	
	## For masterless, mount your file root
	config.vm.synced_folder "conf/srv/", "/srv/"
	
	## Forward ports
	config.vm.network :forwarded_port, guest: 80, host: 80
	config.vm.network :forwarded_port, guest: 3306, host: 3306
	config.vm.network :forwarded_port, guest: 22, host: 22

	## Configure virtual box
	config.vm.provider :virtualbox do |vb|
		vb.customize ["modifyvm", :id, "--memory", "2048"]
		vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
	end	  	
	
	## Set your salt configs here
	config.vm.provision :salt do |salt|
		## Minion config is set to ``file_client: local`` for masterless
		salt.minion_config = "conf/srv/minion"

		## Installs our example formula in "conf/srv/salt"
		salt.run_highstate = true
		
		salt.colorize = true
		salt.log_level = "info"
		salt.verbose = true		
	end
end
