#!/bin/bash
apt-get update
apt-get -y install curl

# create staging directories
if [ ! -d /drop ]; then
  mkdir /drop
fi
if [ ! -d /downloads ]; then
  mkdir /downloads
fi

# download the Chef server package
if [ ! -f /vagrant/chef-server-core_12.16.2-1_amd64.deb ]; then
  echo "Downloading the Chef server package..."
  wget -nv -P /vagrant https://packages.chef.io/files/stable/chef-server/12.16.2/ubuntu/16.04/chef-server-core_12.16.2-1_amd64.deb
fi

# install Chef server
if [ ! $(which chef-server-ctl) ]; then
  echo "Installing Chef server..."
  dpkg -i /vagrant/chef-server-core_12.16.2-1_amd64.deb
  chef-server-ctl reconfigure

  echo "Waiting for services..."
  until (curl -D - http://localhost:8000/_status) | grep "200 OK"; do sleep 15s; done
  while (curl http://localhost:8000/_status) | grep "fail"; do sleep 15s; done

  echo "Creating initial user and organization..."
  chef-server-ctl user-create chefadmin Chef Admin bknop@arbormetrix.com chefadmin --filename /drop/chefadmin.pem
  chef-server-ctl org-create amx "ArborMetrix" --association_user chefadmin --filename arbormetrix-validator.pem

  echo "Installing Chef Management Console..."
  chef-server-ctl install chef-manage
  chef-server-ctl reconfigure 
  chef-manage-ctl reconfigure --accept-license
fi

echo "Your Chef server is ready!"