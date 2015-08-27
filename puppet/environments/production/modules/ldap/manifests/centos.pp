# This is the base CentOS class for ldap
class ldap::centos {
#  include ldap

  $authpath = $::lsbmajdistrelease ? {
    '6'     => '/usr/bin',
    '5'     => '/usr/sbin',
    default => '/usr/bin',
  }

  package { 'nscd':
    ensure => installed
  }
}
