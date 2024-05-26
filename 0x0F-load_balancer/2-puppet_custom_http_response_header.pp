# 2-puppet_custom_http_response_header.pp
# This Puppet script configures Nginx on a new Ubuntu machine to include a custom HTTP header.

# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Configure Nginx for port 80 and a basic HTML page
file { '/var/www/html/index.html':
  ensure  => present,
  content => 'Hello World!',
}

# Allow HTTP traffic through the firewall
exec { 'allow_nginx_http':
  command => '/usr/sbin/ufw allow "Nginx HTTP"',
  path    => '/usr/sbin',
  require => Package['nginx'],
}

# Create a custom configuration file for Nginx
file { '/etc/nginx/conf.d/custom_header.conf':
  ensure  => file,
  content => "add_header X-Served-By \$hostname;\n",
  mode    => '0644',
  owner   => 'root',
  group   => 'root',
  require => Package['nginx'],
}

# Ensure the custom header configuration is included in the default Nginx site configuration
file_line { 'include_custom_header':
  path  => '/etc/nginx/sites-available/default',
  line  => 'include /etc/nginx/conf.d/custom_header.conf;',
  match => '^include /etc/nginx/conf.d/custom_header.conf;$',
  after => 'server {',
  require => File['/etc/nginx/conf.d/custom_header.conf'],
}

# Ensure the Nginx service is running and restarted to apply changes
service { 'nginx':
  ensure     => running,
  enable     => true,
  subscribe  => [File['/etc/nginx/conf.d/custom_header.conf'], File_line['include_custom_header'], File['/var/www/html/index.html']],
}
