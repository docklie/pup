# This class applies to SLES only
class ldap::sles {
  include ldap
  package { ['openldap2-client',
    'pam_ldap',
    'pam_ldap-32bit',
    'nss_ldap',
    'nss_ldap-32bit',]:
      ensure => installed,
  }

  augeas {
    'ldapbase':
    context => '/files/etc/ldap.conf',
    changes => "set base ${::ldap_base_dn}",
    onlyif  => "get base != ${::ldap_base_dn}",
    notify  => Service['nscd'];

    'ldapserver':
    context => '/files/etc/ldap.conf',
    changes => "set uri '${::ldap_server}'",
    onlyif  => "get uri != '${::ldap_server}'",
    notify  => Service['nscd'];

    'ldapssl':
    context => '/files/etc/ldap.conf',
    changes => 'set ssl off',
    onlyif  => 'get ssl != off',
    notify  => Service['nscd'];
  }

  service { 'nscd':
    name   => 'nscd',
    path   => '/etc/init.d',
    binary => '/usr/sbin/nscd'
  }
}
