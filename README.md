# When spinning up a [new instance](https://chef-server/)

[on workstation]

`cd ~/dev/chef/learn-chef`

### Push cookbooks on workstation to server
`knife cookbook upload learn_chef_apache2`

### Install SSL cert on client
`knife ssl fetch <br>
knife ssl check<br>
knife bootstrap chef-client --ssh-user vagrant --sudo --identity-file ~/dev/chef/client/.vagrant/machines/default/virtualbox/private_key --node-name chef-client --run-list 'role[web]'`

### Bootstrap a new node
`knife bootstrap chef-client --ssh-user vagrant --sudo --identity-file ~/dev/chef/client/.vagrant/machines/default/virtualbox/private_key --node-name chef-client --run-list 'recipe[learn_chef_apache2]'`

### Update a cookbook
`knife cookbook upload <cookbook>`

### Update a node
`knife ssh 'name:chef-client' 'sudo chef-client' --ssh-user vagrant --identity-file ~/dev/chef/client/.vagrant/machines/default/virtualbox/private_key --attribute ipaddress`

### Cookbooks & dependency management
`~/dev/chef/learn-chefBerksfile`
`berks install`
`berks upload --no-ssl-verify`