# the mcollective server class

class mcollective::server {

  include ::mcollective

# install the mcollective server package
  package { 'mcollective':
    ensure => present,
  }

  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    ignore => '.svn',
  }

  file { '/usr/libexec/mcollective/mcollective/':
    ensure  => directory,
    source  => 'puppet:///modules/mcollective',
    recurse => false,
  }

  file { '/usr/libexec/mcollective/mcollective/agent/':
    ensure  => directory,
    source  => 'puppet:///modules/mcollective/agent',
    recurse => remote,
  }

  file { '/usr/libexec/mcollective/mcollective/application/':
    ensure  => directory,
    source  => 'puppet:///modules/mcollective/application',
    recurse => remote,
  }

  file { '/usr/libexec/mcollective/mcollective/facts/':
    ensure  => directory,
    source  => 'puppet:///modules/mcollective/facts',
    recurse => remote,
  }

# install files to servers

  file { 'agent-shellcmd.ddl':
    ensure => present,
    path   => '/usr/libexec/mcollective/mcollective/agent/shellcmd.ddl',
    source => 'puppet:///modules/mcollective/agent/shellcmd.ddl',
    mode   => '0755',
  }

  file { 'agent-shellcmd.rb':
    ensure => present,
    path   => '/usr/libexec/mcollective/mcollective/agent/shellcmd.rb',
    source => 'puppet:///modules/mcollective/agent/shellcmd.rb',
    mode   => '0755',
  }

# the server config
  file { 'mcollective-server.cfg':
    ensure  => present,
    source  => 'puppet:///modules/mcollective/server.cfg',
    mode    => '0440',
    path    => '/etc/mcollective/server.cfg',
    notify  => Service['mcollective'],
    require => Package['mcollective'],
  }

# set up the service and ensure it has all files/packages required
  service { 'mcollective':
    ensure     => running,
    hasrestart => true,
    require    => File[['agent-shellcmd.ddl'],['agent-shellcmd.rb'],['mcollective-server.cfg']],
  }
}
