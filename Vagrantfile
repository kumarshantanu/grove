# -*- mode: ruby -*-
# vi: set ft=ruby :

# Box: https://oss-binaries.phusionpassenger.com/vagrant/boxes/2014-04-22/

# See: http://blog.cloudera.com/blog/2013/04/how-to-use-vagrant-to-set-up-a-virtual-hadoop-cluster/

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"


# ==========================
# =====  INIT SCRIPT  ======
# ==========================
$init_script = <<SCRIPT
#!/bin/bash
cat > /etc/hosts <<EOF
127.0.0.1       localhost

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

10.211.55.101   storm1
10.211.55.102   storm2
10.211.55.103   storm3
EOF

apt-get install curl wget vim rlwrap -y
SCRIPT
# ===== END OF INIT SCRIPT =====


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "trusty64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # Enable provisioning with CFEngine. CFEngine Community packages are
  # automatically installed. For example, configure the host as a
  # policy server and optionally a policy file to run:
  #
  # config.vm.provision "cfengine" do |cf|
  #   cf.am_policy_hub = true
  #   # cf.run_file = "motd.cf"
  # end
  #
  # You can also configure and bootstrap a client to an existing
  # policy server:
  #
  # config.vm.provision "cfengine" do |cf|
  #   cf.policy_server_address = "10.0.2.15"
  # end

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file default.pp in the manifests_path directory.
  #
  # config.vm.provision "puppet" do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "site.pp"
  # end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  # config.vm.provision "chef_solo" do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  # end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision "chef_client" do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # If you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"

  config.vm.provision "ansible" do |ansible|
        ansible.playbook = "download.yml"
  end

  config.vm.define :master do |master|
    master.vm.box = "trusty64"
    master.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"]  = "2048"
    end
    master.vm.provider :virtualbox do |v|
      v.name = "storm1"
      v.customize ["modifyvm", :id, "--memory", "2048"]
    end
    master.vm.network :private_network, ip: "10.211.55.101"
    master.vm.hostname = "storm1"
    master.vm.provision :shell, :inline => $init_script
    master.vm.provision "ansible" do |ansible|
        ansible.playbook = "playbook.yml"
    end
  end

  config.vm.define :slave1 do |slave1|
    slave1.vm.box = "trusty64"
    slave1.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"]  = "2048"
    end
    slave1.vm.provider :virtualbox do |v|
      v.name = "storm2"
      v.customize ["modifyvm", :id, "--memory", "2048"]
    end
    slave1.vm.network :private_network, ip: "10.211.55.102"
    slave1.vm.hostname = "storm2"
    slave1.vm.provision :shell, :inline => $init_script
    slave1.vm.provision "ansible" do |ansible|
        ansible.playbook = "playbook.yml"
    end
  end

  config.vm.define :slave2 do |slave2|
    slave2.vm.box = "trusty64"
    slave2.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"]  = "2048"
    end
    slave2.vm.provider :virtualbox do |v|
      v.name = "storm3"
      v.customize ["modifyvm", :id, "--memory", "2048"]
    end
    slave2.vm.network :private_network, ip: "10.211.55.103"
    slave2.vm.hostname = "storm3"
    slave2.vm.provision :shell, :inline => $init_script
    slave2.vm.provision "ansible" do |ansible|
        ansible.playbook = "playbook.yml"
    end
  end

end
