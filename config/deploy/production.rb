server '52.68.16.56', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/sakura/.ssh/id_rsa'
