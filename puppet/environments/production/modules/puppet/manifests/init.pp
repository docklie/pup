# == Class: puppet
class { 'puppet': }

# puppet class
class puppet {
  package { 'puppet':
    ensure => latest,
  }

  file { 'puppet.conf':
    ensure => present,
    name   => '/etc/puppet/puppet.conf',
    mode   => '0644',
    source => 'puppet:///modules/puppet/puppet.conf',
  }

  file { 'auth.conf':
    ensure => present,
    mode   => '0644',
    name   => '/etc/puppet/auth.conf',
    source => 'puppet:///modules/puppet/puppet.conf',
  }

  service { 'puppet':
    ensure => running,
    enable => true,
    require => Package['puppet'],
    notify => File['puppet.conf'],
  }

#  cron { 'puppet-restart':
#    ensure  => present,
#    command => '/network-raid/opt/systems/bin/cron_restart_puppetsplay',
#    hour    => 1,
#    minute  => 30,
#    user    => 'root',
#  }
}
