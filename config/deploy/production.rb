server '13.115.31.126', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/home/app/.ssh/id_rsa.pub'
