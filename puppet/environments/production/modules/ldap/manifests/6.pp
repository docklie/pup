# This class applies to CentOS 6 only.
class ldap::6 {
# include ldap::centos
  require ldap::centos


 # file { '/etc/nscd.conf':
 #   ensure  => present,
 #   mode    => '0644',
 #   notify  => Service['nscd'],
 #   require => Package['nscd'],
 #   source  => 'puppet:///modules/ldap/nscd6.conf',
 # }


  exec { 'authconfig-update1':
    command     => 'authconfig --updateall --enablesssd --enablesssdauth --disableldap --disableldapauth',
    path        => '/usr/sbin',
    refreshonly => true,
    require     => Package['sssd'],
  }

  file { '/etc/sssd/sssd.conf':
    ensure   => present,
    mode     => '0600',
    notify   => Service['sssd'],
    require  => Package['sssd'],
    owner    => 'root',
    group    => 'root',
   source   => "puppet:///modules/ldap/${::domain}/sssd.conf",
  }

  augeas {
    'legacy':
    context => '/files/etc/sysconfig/authconfig',
    changes => 'set FORCELEGACY yes',
    onlyif  => 'get FORCELEGACY != yes',
    notify  => Exec['authconfig-update1'],
  }

  package { 'sssd': ensure => latest }
  package { 'sssd-client.i686': ensure => latest }
  package { 'nss-pam-ldapd': ensure => absent }

  package { 'pam_ldap':
    ensure  => absent,
    require => Package['nss-pam-ldapd'],
  }
  package { 'nslcd': ensure => absent }
  service { 'nscd': ensure => stopped }
  service { 'sssd':
    ensure  => running,
    require => Package[['sssd-client.i686'],['sssd']],
  }
}
