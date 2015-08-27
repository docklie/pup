# == Class: branding
class { 'branding': }
class branding {
  file { '/boot/grub/splash.xpm.gz':
    ensure => present,
    source => 'puppet:///modules/branding/splash.xpm.gz',
  }

  case $::operatingsystemrelease {
    /^5\./: {
      file {'/usr/share/rhgb/large-computer.png':
        ensure => present,
        source => 'puppet:///modules/branding/large-computer.png';
      '/usr/share/rhgb/system-logo.png':
        ensure => present,
        source => 'puppet:///modules/branding/background.png';
    }
  }
  /^6\./: {
      file {'/usr/share/backgrounds/maxeler_1920x1200.jpg':
        ensure => present,
        source => 'puppet:///modules/branding/background6.png';
      '/usr/share/backgrounds/maxeler_1920x1440.jpg':
        ensure => present,
        source => 'puppet:///modules/branding/background6.png';
      '/usr/share/backgrounds/default.xml':
        ensure => present,
        source => 'puppet:///modules/branding/default.xml.centos6';
      '/usr/share/backgrounds/default.png':
        ensure => present,
        source => 'puppet:///modules/branding/default6.png';
      }
    }
  }
}
