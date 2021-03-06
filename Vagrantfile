Vagrant::Config.run do |config|
  config.vm.define :chef do |chef_config|
    chef_config.vm.box = "vvii"
    # chef_config.vm.box_url = "http://domain.com/path/to/above.box"
    chef_config.vm.boot_mode = :gui
    chef_config.vm.forward_port "http", 80, 9080
    chef_config.vm.forward_port "chefapi", 443, 9443
    chef_config.vm.forward_port "chefgui", 444, 9444
    #chef_config.vm.network "33.33.33.10"
    chef_config.vm.customize do |vm|
      vm.name = "Chef Server"
      #vm.memory_size = 512
      vm.vram_size = 12
      # bridged nic might need promisc... at some point
      # VBoxManage modifyvm --nicpromisc2 allow-all

    end
    #chef_config.vm.share_folder "v-chef-cache", "/chefcache", "cache" # mounts last
    chef_config.vm.provision :chef_solo do |chef|
      #chef.nfs = true # seems broken, and you need to apt-get install nfs-kernel-server
      chef.data_bags_path = "data_bags" 
      chef.provisioning_path = "/vagrant/cache"
      chef.cookbooks_path = "cookbooks", "site-cookbooks"
      chef.add_recipe "pxe_dust::server"
      chef.add_recipe "pxe_chef"
      chef.add_recipe "dnsmasq"
      chef.add_recipe "chef-bootstrap"
      #chef.add_recipe "chef-bootstrap::apache-proxy"
      #chef.add_recipe "pxe_dust::ubuntu-studio"
      chef.add_recipe "unattended"
      
      chef.json = {
        "tftp" => {
          "directory" => "/var/lib/tftpboot"
        },
        "pxe_dust" => {
          "arch" => "amd64",
          "version" => "natty",
          "directory" => "/var/www",
          "user" => {
            "fullname" => ":ii is Ideal Infrastructure",
            "username" => "ii",
            # This should be able to be done cross-platform via ruby and not shelling out
            # http://help.opscode.com/discussions/questions/253-user-resource-sha512-shadow-hash-generation
            #salt specified so the hash is the same each time
            "crypted_password" => `echo 'ii' | mkpasswd -m sha-512 -S vviivvii -s`
            
          }
        },
        "samba" => {
          "interfaces" => "eth0 eth1",
          "hosts_allow" => "0.0.0.0/32"
        },
        "unattended" => {
          "xp_pro_key" => 'MMX36-FRX2X-8XQYD-X77HV-XXXXX'
        },
        "chef_server"=> {
          "webui_enabled"=>true,
          "server_url"=>"http://#{config.vm.box}:4000",
          "init_style"=>"init",
          "ssl_req"=>
          "/C=NZ/ST=Bay of Plenty/L=Tauranga/O=PassionEngine.org/OU=DevOps/CN=chef.server/emailAddress=devops@passionengine.org"
        },
        "apache"=> {
          "contact"=>"devops@passionengine.org",
          "listen_ports"=>["80", "443"],
          "server_aliases"=>["#{config.vm.box}"]
        }
      }
    end
  end
end
