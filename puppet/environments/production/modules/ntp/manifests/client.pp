# client class for ntp
class ntp::client {
  include ::ntp

  $servicename = $::operatingsystem ? {
    'CentOS' => 'ntpd',
    'Debian' => 'ntpd',
    'SLES'   => 'ntp',
    default  => 'ntpd',
  }

  package { 'ntp':
    ensure => installed,
  }

  service  { $servicename:
    ensure => running,
    enable => true,
  }

  file { 'ntp.conf':
    name    => '/etc/ntp.conf',
    mode    => '0644',
    require => Package['ntp'],
# notify  => Service[$::servicename],
    source  => ['puppet:///modules/ntp/ntp.conf'],
  }
}
