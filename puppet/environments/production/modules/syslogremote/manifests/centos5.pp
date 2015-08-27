# centos5 syslogremote class
class syslogremote::centos5 {
  include ::syslogremote

  file { 'syslog.conf':
    path    => '/etc/syslog.conf',
    source  => 'puppet:///modules/syslogremote/syslog-cluster.conf',
    notify  => Service['syslog'],
    require => Package['sysklogd'],
  }

  service { 'syslog':
    ensure => running,
  }

  package { 'sysklogd':
    ensure => latest,
  }
}
