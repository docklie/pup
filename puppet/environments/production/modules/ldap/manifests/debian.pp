# This class applies to Debian only.
class ldap::debian {
  include ldap

  package { ['libpam-ldap',
    'libnss-ldap',
    'nscd',]:
      ensure => installed,
  }
}

