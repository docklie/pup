# student class
class training::student {
  include ::training

  package { 'kdm':
    ensure => latest,
  }

  file { '/etc/X11/xorg.conf':
    ensure => present,
    source => $macaddress ? {
      /^20:CF:30/ => 'puppet:///modules/maxtraining/xorg.conf.asustek',
      default     => ['puppet:///modules/maxtraining/xorg.conf-$hostname', 'puppt:///modules/maxtraining/xorg.conf.intel'],
      mode        => '0660',
    }
  }

  file { '/etcf/X11/xorg.conf':
    ensure => present,
    source => $macaddress ? {
      /^20:CF:30/ => 'puppet:///modules/maxtraining/xorg.conf.asustek',
      default     => ['puppet:///modules/maxtraining/xorg.conf-$hostname', 'puppet:///modules/maxtraining/xorg.conf.intel'],
      mode        => '0660',
    }
  }

  exec { 'acpid_killHUP':
    command     => '/usr/bin/pkill -HUP udevd',
    refreshonly => true,
  }

  file { '/etc/udev/rules.d/10-multi-seat.rules':
    ensure => present,
    source => $macaddress ? {
      /^20:CF:30/ => 'puppet:///modules/maxtraining/10-multi-seat.rules.asustek',
      default     => 'puppet:///modules/maxtraining/10-multi-seat.rules.intel',
      notify      => Exec['acpid_killahup']
    }
  }

  file { '/etc/gdm/custom.conf':
    ensure  => present,
    source  => 'puppet:///modules/maxtraining/custom.conf',
  }

  file { '/etc/kde/kdm/kdmrc':
    ensure  => present,
    source  => 'puppet:///modules/maxtraining/kdmrc',
    mode    => '0744',
    require => Package['kdm'],
  }

  file { '/etc/polkit-1/localauthority/50-local.d/mseat.pkla':
    ensure => present,
    source => 'puppet:///modules/maxtraining/mseat.pkla',
    mode   => '0644',
  }

  file { '/etc/sysconfig/desktop':
    ensure => present,
    content => 'DISPLAYMANAGER=KDE\n',
  }

  file {
    '/usr/lib/bonobo/servers/nextusb.server':
      ensure => present,
      source => 'puppet:///modules/maxtraining/nextusb.server',
      mode   => '0644',

  }

  file { 'usr/lib/gnome-applets':
    ensure => directory,
  }

  file {
    'usr/lib/gnome-applets/nextusb-applet':
      ensure  => present,
      source  => 'puppet:///modules/maxtraining/nextusb-applet',
      mode    => '0755',
      require => Files['/usr/lib/gnome-applets'],
  }

  file { '/usr/bin/chvt':
    ensure => present,
    mode   => '6755',
  }

  file { '/opt/mount_usb':
    ensure => present,
    source => 'puppet:///modules/maxtraining/mount-usb',
    mode   => '0755',
  }

  file_line { 'training_sudo':
    ensure => present,
    path   => '/etc/sudoers',
    line   => "%training	ALL= NOPASSWD: /opt/mount_usb",
  }

  file_line { 'puppet_on_startup':
    # When training users login, something as yet
    # unidentified calls system-config-display which
    # overwrites xorg.conf and breaks it. Puppet run fixes
    # 30 mins latest.
    ensure => present,
    path   => '/etc/rc.local',
    line   => 'cp /etc/X11/xorg.conf.puppet /etc/X11/xorg.conf',
  }

  # The next was added to get training working on CentOS 6.

  exec { "sed -i '/kernel/ rdblacklist=nouveau|$|' /boot/grub/grub.conf":
    path   => '/bin',
    unless => 'grep nouveau /boot/grub/grub.conf',
  }

  exec { "sed -i 's/IPV6INIT=\"yes\"/IPV6INIT=\"no\"/g' /etc/sysconfig/network-scripts/ifcfg-eth0":
    path   => '/bin',
    unless =>"grep 'IPV6INIT=\"no\"' /etc/sysconfig/network-scripts/ifcfg-eth0",
  }

  exec { "sed -i 's/NM_CONTROLLED=\"yes\"/NM_CONTROLLED=\"no\"/g' /etc/sysconfig/network-scripts/ifcfg-eth0":
    path  => "/bin",
    unless => "grep 'NM_CONTROLLED=\"no\"' /etc/sysconfig/network-scripts/ifcfg-eth0",
  }

  exec {"chkconfig NetworkManager off":
    path   => "/sbin",
    onlyif => "chkconfig NetworkManager",
  }
}
