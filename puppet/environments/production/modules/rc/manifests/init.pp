# == Class: rc
class { 'rc': }

# rc class
class rc {
  file { '/etc/rc.local':
    ensure => present,
  }

  file_line { 'rc_local':
    ensure => present,
    path   => '/etc/rc.local',
    line   => '/network-raid/opt/systems/bin/check_nic_rx.py',
  }

  file_line { 'rc_local_msr1':
    ensure => present,
    path   => '/etc/rc.local',
    line   => 'chown root:maxusers /dev/cpu/*/msr',
  }

  file_line { 'rc_local_msr2':
    ensure => present,
    path   => '/etc/rc.local',
    line   => 'chmod g+rw /dev/cpu/*/msr',
  }
}
