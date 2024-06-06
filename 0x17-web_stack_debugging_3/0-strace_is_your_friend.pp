# 0-strace_is_your_friend.pp

file { '/var/www/html':
  ensure  => 'directory',
  mode    => '0755',
  recurse => true,
}
