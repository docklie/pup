# class puppet_restart
# this class simply restarts puppet after ldap class
# has completed to allow puppet to reload
# facts
class puppet_restart {
  include ::ldap

  exec { 'restart':
    command => '/etc/init.d/puppet stop && /etc/init.d/puppet start',
  }
}
