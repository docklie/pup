# --class ssh
class { 'ssh': }

# ssh class
class ssh {
  service { 'sshd':
    ensure => running,
  }

  file { '/root/.ssh':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    recurse => true,
  }

  file { '/root/.ssh/authorized_keys':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    require => File['/root/.ssh'],
  }
}
