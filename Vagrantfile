vmdomain = '.myvagrant.lcl'

redismasterOptions = {}
redismasterOptions[:ip_address] = '192.168.33.11'
redismasterOptions[:host_name] = 'master' + vmdomain

redisslaveOptions = {}
redisslaveOptions[:ip_address] = '192.168.33.12'
redisslaveOptions[:host_name] = 'slave' + vmdomain


Vagrant.configure(2) do |config|
  
	config.vm.box = "ubuntu/trusty64"
  
    config.vm.define "master" do |master|
		master.vm.network "private_network", ip: redismasterOptions[:ip_address]
		master.vm.hostname = redismasterOptions[:host_name]
		
		master.vm.provider "virtualbox" do |vb|			
			vb.memory = 1024
		end
		
		master.vm.provision "shell", path: "install.sh"
		
	end
	
	
	config.vm.define "slave" do |slave|
		slave.vm.network "private_network", ip: redisslaveOptions[:ip_address]
		slave.vm.hostname = redisslaveOptions[:host_name]  	
	end
	
end