# ---class ntp
class { 'ntp': }

# ntp class
class ntp {

#include ntp::client
#include ntp::server
# ntp server class not in use

#  $servicename = $::operatingsystem ? {
#    'CentOS' => 'ntpd',
#    'Debian' => 'ntpd',
#    'SLES'   => 'ntp',
#    default  => 'ntpd',
#  }

#  package { 'ntp':
#    ensure => installed,
#  }

#  service { $servicename:
#    ensure => running,
#    enable => true,
#  }
}

