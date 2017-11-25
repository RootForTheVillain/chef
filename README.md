# When spinning up a [new instance](https://chef-server/)

[on workstation]

`cd ~/dev/chef/learn-chef`

### Push cookbooks on workstation to server
`knife cookbook upload learn_chef_apache2`

### Install SSL cert on client
`knife ssl fetch`
`knife ssl check`

### Spin up new Chef node
`knife bootstrap chef-client --ssh-user vagrant --sudo --identity-file ~/dev/chef/client/.vagrant/machines/default/virtualbox/private_key --node-name chef-client --run-list 'recipe[learn_chef_apache2]'`