Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision "shell" do |s|
    s.path = "provision/setup.sh"
  end
end
