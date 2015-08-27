# == class: fstab
class { 'fstab': }


# fstab class
class fstab {

#######################################################################
# NB: /network-raid/maxeler file is created below to allow access to /networkraid/maxeler without access to
# the rest of /networkraid. 
# Remove the record for /networkraid/maxeler both in init.pp and london.pp when /networkraid is 
# being fully mounted again.


  case $::domain {
    'london.maxeler.com':   { include fstab::london }
    'houston.maxeler.com':  { include fstab::houston }
    'paloalto.maxeler.com': { include fstab::paloalto }
    default:                { include fstab::london }
  }

  $servicename = $::lsbmajdistrelease ? {
    '6'     => 'sssd',
    '5'     => 'sssd',
  }

  file { ['/local-scratch', '/network-maxtest']:
    ensure  => directory,
    mode    => '0777',
   # require => Service[$servicename],
  }

########******************************************************************

  file { ['/network-raid', '/network-raid/maxeler', '/scratch']:
    ensure  => directory,
    owner   => 'ashley',
    group   => 'employees',
    #require => Service[$servicename],
  }

  file { '/home':
    ensure  => directory,
    owner   => 'ashley',
    group   => 'maxusers',
    #require => Service[$servicename],
  }

  file { '/maxtest':
    ensure => directory,
    mode   => '0777',
  }

  file { '/network-tests':
    ensure => directory,
    mode   => '0775',
  }

  file { ['/network-scratch',
    '/network-nfs-test',
    '/network-home',
    '/network-infrastructure']:
      ensure  => directory,
      owner   => 'ashley',
      group   => 'maxusers',
      mode    => '0775',
     # require => Service[$servicename],
  }
}
