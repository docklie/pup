# -- Class ups
class { 'ups': }

# NB: CONFIG FILES HAVE BEEN ADDED TO MODULES/UPS/FILES/
#FOR TESTING PURPOSES.

# ups class
class ups {
  package { 'apcupsd':
    ensure => installed,
  }

  service { 'apcupsd':
    ensure    => running,
    enable    => true,
    require   => Package['apcupsd'],
    subscribe => File['apcupsd.conf'],
  }

  file { 'apcupsd.conf':
    ensure  => file,
#    ensure  => present,
    name    => '/etc/apcupsd/apcupsd.conf',
    mode    => '0644',
    require => Package['apcupsd'],
    #source  => 'puppet:///modules/ups/apcupsd.conf',
    content => template('ups/apcupsd_conf.erb'),
  }
}
