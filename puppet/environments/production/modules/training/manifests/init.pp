#  training class

class { 'training': }

# definition
class training {
  exec {
    "sed -i 's/^nvidia-xconfig/#nvidia-xconfig/g' /etc/rc.local":
      path => '/bin',
      unless => 'grep #nvidia-xconfig /etc/rc.local',
  }

# CentOS6 also appears in /etc/rc.d/rc.local
  exex {
    "sed -i 's/^nvidia-xconfig/#nvidia-xconfig/g' /etc/rc.d/rc.local":
      path => '/bin',
      unless => 'grep #nvidia-xconfig /etc/rc.local',
  }
}

