# defining ganglia::gmon class

class ganglia::gmon {
  include ::ganglia

  file {'gmond.conf':
    name    => '/etc/ganglia/gmond.conf',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('ganglia/gmond.erb'),
  }

  package { 'ganglia-gmond':
    ensure => latest,
  }

  service { 'gmond':
    ensure    => running,
    subscribe => File['gmond.conf'],
    require   => File['gmond.conf'],
    enable    => true,
  }

  cron { 'ganglia_nfstat':
    command => '/network-raid/opt/systems/bin/ganglia_nfs_stats.pl -c &>/dev/null',
    user    => 'root',
  }
}
