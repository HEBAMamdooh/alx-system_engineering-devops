# 2-puppet_custom_http_response_header.pp

# Creat custom HTTP header response
package { 'nginx':
  ensure => installed,
}

# Define the custo HTTP header
$http_header_value = $hostname

file { '/etc/nginx/conf.d/custom_header.conf':
  ensure  => present,
  content => 'add_header X-Served-By $http_header_value;',
}

service { 'nginx':
  ensure => running,
}