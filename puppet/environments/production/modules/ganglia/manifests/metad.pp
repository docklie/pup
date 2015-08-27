#declaring  metad class
class { 'metad': }

# defining metad class
class ganglia::metad {
  include ::ganglia

  package { 'ganglia-gmetad':
    ensure => latest,
  }

  service { 'gmetad':
    ensure    => running,
    enable    => true,
    require   => File['gmetad.conf'],
    subscribe => File['gmetad.conf'],
  }
}

