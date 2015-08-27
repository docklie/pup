# mcollective class
class { 'mcollective': }

# mcollective common files, to be installed on both servers and clients
class mcollective {
  package { 'mcollective-common':
    ensure => present,
  }

  package { 'rubygem-stomp':
    ensure => present,
  }

  package { 'open4':
    ensure => present,
    provider => gem,
  }
}
