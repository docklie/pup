# == Class: avahi
class { 'avahi': }

# avahi class
class avahi {
  service { 'avahi-daemon':
    ensure => stopped,
  }
}
