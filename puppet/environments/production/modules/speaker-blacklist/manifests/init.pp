# class declararion speaker-blacklist
class { 'speaker-blacklist': }

# class definition speaker-blacklist
class speaker-blacklist {
  augeas { 'blacklist-speaker':
    context => '/files/etc/modprobe.d/blacklist',
    changes => 'set blacklist[last()+1] pcspkr',
    onlyif  => "match blacklist[.='pcspkr'] size == 0",
  }

  augeas { 'enable-sysrq':
    context => '/files/etc/sysctl.conf',
    changes => 'set kernel.sysrq 1',
    onlyif  => 'get kernel.sysrq != 1',
  }

  file { '/etc/modprobe.d/speaker.conf':
    ensure => present,
  }

  file_line { 'modules_conf':
    path    => '/etc/modprobe.d/speaker.conf',
    line    => 'alias pcspkr off',
    ensure  => present,
    require => File['/etc/modprobe.d/speaker.conf'],
  }
}
