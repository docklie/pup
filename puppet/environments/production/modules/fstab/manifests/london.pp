# fstab mounts for london site only
class { 'london': }

# defining london class
class fstab::london {

mount { '/scratch':
    ensure  => 'mounted',
    device  => 'filesrv2.critical.maxeler.com:/zpool011/networkscratch',
    fstype  => 'nfs',
    options => 'vers=3,noatime',
    atboot  => true,
    require => File['/scratch'],
  }

#  mount { 'network-scratch':
#    ensure  => 'mounted',
#    device  => 'filesrv1.critical.maxeler.com:/zpool002/networkscratch',
#    fstype  => 'nfs',
#    options => 'vers=3,noatime',
#    atboot  => true,
#    require => File['/network-scratch'],
#  }

  mount { '/maxtest':
    ensure  => 'mounted',
    device  => 'filesrv2.critical.maxeler.com:/zpool011/maxtest',
    fstype  => 'nfs',
    options => 'nfsvers=3',
    atboot  => true,
    require => File['/maxtest'],
  }

  mount { '/network-raid':
    ensure  => 'absent',
    device  => 'filesrv2.critical.maxeler.com:/zpool011/networkraid',
    fstype  => 'nfs',
    options => 'vers=3,noatime',
    atboot  => false,
    require => File['/network-raid'],
  }
  
mount { '/network-raid/maxeler':
    ensure  => 'mounted',
    device  => 'filesrv2.critical.maxeler.com:/zpool011/networkraid/maxeler',
    fstype  => 'nfs',
    options => 'vers=3,noatime',
    atboot  => true,
    require => File['/network-raid/maxeler'],
  }

  mount { '/home':
    ensure  => 'absent',
    device  => 'filesrv2.critical.maxeler.com:/zpool011/homes',
    fstype  => 'nfs',
    options => 'vers=3,noatime',
    atboot  => false,
    require => File['/home'],
  }

#  mount { '/network-maxtest':
#    ensure   => 'mounted',
#    device   => 'filesrv4.cluster.maxeler.com:/zpool004/maxtest',
#    fstype   => 'nfs',
#    options  => 'vers=3,noatime',
#    atboot   => true,
#    remounts => false,
#    require  => File['/network-maxtest'],
#  }

  mount { '/network-home':
    ensure  => 'mounted',
    device  => 'filesrv2.critical.maxeler.com:/zpool011/homes',
    fstype  => 'nfs',
    options => 'vers=3,noatime',
    atboot  => true,
    require => File['/network-home'],
  }

  mount { '/network-tests':
    ensure  => 'mounted',
    device  => 'filesrv3.cluster.maxeler.com:/zpool012/tests',
    fstype  => 'nfs',
    options => 'vers=3,noatime',
    atboot  => true,
    require => File['/network-tests'],
  }

  mount { '/network-infrastructure':
    ensure  => 'mounted',
    device  => 'filesrv2.critical.maxeler.com:/zpool011/networkinfrastructure',
    fstype  => 'nfs',
    options => 'vers=3,noatime',
    atboot  => true,
    require => File['/network-infrastructure'],
  }
}
