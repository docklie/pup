# trainer class

class training::trainer {
  include ::training

  file { '/etc/X11/xorg.conf':
    ensure => present,
    source => 'puppet:///modules/maxtraining/xorg.conf-tutor',
    mode   => '0660',
  }
}
