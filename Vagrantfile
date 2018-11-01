# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
N = 3
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.provision "shell", inline: "sudo apt-get update && sudo apt-get install -y python python-dev"
  config.vm.provision "shell", inline: "rm /etc/profile.d/vault.sh || echo"
  config.vm.provision "shell", inline: "echo export VAULT_ADDR=#{ENV['VAULT_ADDR']} >> /etc/profile.d/vault.sh"
  config.vm.provision "shell", inline: "echo export VAULT_TOKEN=#{ENV['VAULT_TOKEN']} >> /etc/profile.d/vault.sh"
  (1..N).each do |machine_id|
    config.vm.define "hashi#{machine_id}" do |hashi|
      hashi.vm.hostname = "hashi#{machine_id}"
      hashi.vm.network "private_network", ip: "192.168.77.#{20+machine_id}"
      hashi.vm.provision "shell", inline: "echo 192.168.77.#{20+machine_id} > /etc/hostaddr"
      if machine_id == N
        hashi.vm.network "forwarded_port", guest: 8080, host: 8080
        hashi.vm.network "forwarded_port", guest: 8500, host: 8500
        hashi.vm.network "forwarded_port", guest: 8200, host: 8200
        hashi.vm.network "forwarded_port", guest: 443, host: 8443
        hashi.vm.provision "ansible" do |ansible|
          ansible.playbook = "playbooks/hashistack.yaml"
          ansible.limit = "hashistack"
          ansible.groups = {
            "hashistack" => ["hashi1", "hashi2", "hashi3"],
            "all_groups:children" => ["hashistack"],
            "hashistack:vars" => {
              "vault_addr" => "#{ENV['VAULT_ADDR']}",
              "vault_token" => "#{ENV['VAULT_TOKEN']}",
              "consul_addr" => "#{ENV['CONSUL_HTTP_ADDR']}",
              "okta_token" => "#{ENV['OKTA_TOKEN']}",
              "env" => "production",
              "install" => "enterprise",
              "vault_license" => "/vagrant/vault.license"
            }
          }
        end
      end
    end
  end
end
