#Enable the user holberton to login and open files without errors

# Increase hard file limit for holberton user
file_line { 'increase-hard-file-limit-for-holberton-user':
  path  => '/etc/security/limits.conf',
  line  => 'holberton hard nofile 50000',
  match => '^holberton hard nofile',
}

# Increase soft file limit for holberton user
file_line { 'increase-soft-file-limit-for-holberton-user':
  path  => '/etc/security/limits.conf',
  line  => 'holberton soft nofile 50000',
  match => '^holberton soft nofile',
}
