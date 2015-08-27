# maxq class
class { 'maxq': }

# maxq class
class maxq {
  file { ['/var/log/maxq', '/etc/maxq']:
    ensure  => directory,
    owner   => 'maxq',
    group   => 'maxusers',
    recurse => true,
  }

  file { '/etc/init.d/maxqworkerd':
    ensure => present,
    mode   => '0700',
    source => 'puppet:///modules/maxq/maxqworkerd',
  }

  file { '/etc/sysconfig/maxq':
    ensure => present,
    source => 'puppet:///modules/maxq/',
  }

  service { 'maxqworkerd':
    ensure    => running,
    enable    => true,
    require   => File['/etc/init.d/maxqworkerd'],
    hasstatus => true,
  }
}
