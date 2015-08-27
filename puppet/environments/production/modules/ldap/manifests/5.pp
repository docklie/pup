# This class applies to centos5 only
class ldap::5 {
  include ldap::centos

  service { 'nscd':
    ensure => stopped
  }

  file { '/etc/nscd.conf':
    ensure  => present,
    mode    => '0644',
    notify  => Service['nscd'],
    require => Package['nscd'],
    source  => 'puppet:///modules/ldap/nscd.conf',
  }

  exec { 'authconfig-update':
    command     => '/usr/sbin/authconfig --updateall',
    path        => $authpath,
    refreshonly => true,
  }

  augeas {
    'ldapbase':
    context => '/files/etc/ldap.conf',
    changes => "set base ${::ldap_base_dn}",
    onlyif  => "get base != ${::ldap_base_dn}",
    notify  => Exec['authconfig-update'];

    'ldapserver':
    context => '/files/etc/ldap.conf',
    changes => "set uri '${::ldap_server}'",
    onlyif  => "get uri != '${::ldap_server}'",
    notify  => Exec['authconfig-update'];

    'ldap':
    context => '/files/etc/sysconfig/authconfig',
    changes => 'set USELDAP yes',
    onlyif  => 'get USELDAP != yes',
    notify  => Exec['authconfig-update'];

    'ldapauth':
    context => '/files/etc/sysconfig/authconfig',
    changes => 'set USELDAPAUTH yes',
    onlyif  => 'get USELDAPAUTH != yes',
    notify  => Exec['authconfig-update'];

    'shadow':
    context => '/files/etc/sysconfig/authconfig',
    changes => 'set USESHADOW yes',
    onlyif  => 'get USESHADOW != yes',
    notify  => Exec['authconfig-update'];
  }
}
