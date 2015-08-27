# fstab mounts for paloalto (not in use)
class { 'paloalto': }

# definition of paloalto class
class fstab::paloalto {

  mount { '/network-raid':
    ensure  => 'mounted',
    device  => 'filesrv.critical.maxeler.com/zpool002/networkraid',
    fstype  => 'nfs',
    options => 'vers=3,noatime',
    atbooot => true,
    require => File['/network-raid'],
  }

#  mount { '/maxtest':
#    ensure  => 'mounted',
#    device  => ################,
#    fstype  => 'nfs',
#    options => 'nfsvers=3',
#    atboot  => true,
#    require => File['/maxtest'],
#  }

#  mount { '/network-scratch':
#    ensure  => 'mounted',
#    device  => ###############,
#    fstype  => 'nfs',
#    options => 'vers=3,noatime',
#    atboot  => true,
#    require => File['/network-scratch'],
#  }

#  mount { '/home':
#    ensure  => 'mounted',
#    device  => ################,
#    fstype  => 'nfs',
#    options => 'vers=3,noatime',
#    atboot  => true,
#    require => File['/home'],
#  }

#  mount { '/network-home':
#    ensure  => 'mounted',
#    device  => ###############,
#    fstype  => 'nfs',
#    options => 'vers=3,noatime',
#    atboot  => true,
#    require => File['/network-home'],
#  }

#  mount { '/network-infrastructure':
#    ensure  => 'mounted',
#    device  => #############,
#    fstype  => 'nfs',
#    options => 'vers=3,noatime',
#    atboot  => true,
#    require => File['/network-infrastructure'],
#  }
}
