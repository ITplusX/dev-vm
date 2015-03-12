# ITplusX/dev-vm
@author: Vaclav Janoch <janoch@itplusx.de>

# Generation of base package

Maybe the virtual box guest addition has not been updated in the used basebox. To be sure we update it manually. Follow the following steps:

1. `vagrant plugin install vagrant-vbguest`
2. `vagrant up`
3. Manual steps within vm
	1. Set date.timezone
		`vi /etc/php.ini`
		Serach: `/date.timezone`
		Change to: `date.timezone = "Europe/Berlin"`
3. `vagrant package`
4. Create new version of 

## Files

1. insecure_private_key.ppk
This file is a Putty Private Key representations of "C:\Users\{user-home}\.vagrant.d\insecure_private_key". Add it to pageant and login to vagrant with the user called vagrant.

## What has been installed?

I have tried to install/provision everything with salt. It took to much time. So I decided to do it manually.

1. Use vagrant to get basebox and setup ports.

2. Install Packages (follow these steps):


# Todo
set aliases
image magick