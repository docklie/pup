# centos6 syslogremote class
class syslogremote::centos6 {
  include ::syslogremote

  file { 'rsyslog.conf':
    path    => '/etc/rsyslog.conf',
   source  => 'puppet:///modules/syslogremote/rsyslog-cluster.conf',
    notify  => Service['rsyslog'],
    require => Package['rsyslog'],
  }

  package { 'rsyslog':
    ensure => latest,
  }

  service { 'rsyslog':
    ensure => running,
  }
}
