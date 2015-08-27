# class to ensure NetworkManager stays off
class { 'networkmanager': }

# class documented
class networkmanager {

  service { 'NetworkManager':
    ensure => stopped,
  }
}
