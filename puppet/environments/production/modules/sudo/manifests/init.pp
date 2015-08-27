# declare sudo class
class { 'sudo': }

# define sudo class
class sudo {
  file { '/etc/sudoers':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0440',
   source => ['puppet:///modules/sudo/sudoers-$operatingsystem','puppet:///modules/sudo/sudoers'],
  }

  file { '/etc/sudoers.local':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0440',
   source => ["puppet:///modules/sudo/sudoers.local-${::hostname}",'puppet:///modules/sudo/sudoers.local'],
  }
}
