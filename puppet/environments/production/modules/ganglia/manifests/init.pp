# Full description of class ganglia here.
class { 'ganglia': }

# ganglia class
class ganglia {
  file { '/etc/ganglia':
    ensure => directory,
  }
}
