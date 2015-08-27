# == Class: syslogremote
class { 'syslogremote': }

# syslogrremote class
class syslogremote {
  include "syslogremote::${::operatingsystem}${::lsbmajdistrelease}"
}
