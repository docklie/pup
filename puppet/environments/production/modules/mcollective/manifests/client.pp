# mcollective client class

class mcollective::client {

  include ::mcollective
  include mcollective::server

  package { 'mcollective-client':
    ensure => present,
  }

  file { 'mcollective-client.cfg':
    ensure    => present,
    source    => 'puppet:///modules/mcollective/client.cfg',
    path      => '/etc/mcollective/client.cfg',
    owner     => 'root',
    group     => 'root',
    mode      => '0644',
    require   => Package['mcollective-client'],
    subscribe => Package['mcollective-client'],
  }

  file { 'app-shellcmd.rb':
    ensure  => present,
    source  => 'puppet:///modules/mcollective/application/shellcmd.rb',
    path    => '/usr/libexec/mcollective/mcollective/application/shellcmd.rb',
    mode    => '0755',
    owner   => 'root',
    require => Package['mcollective-client'],
  }
}
