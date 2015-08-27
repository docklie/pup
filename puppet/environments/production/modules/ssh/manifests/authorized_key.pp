# class for ssh key
class ssh::authorized_key {
  include ::ssh

  ssh_authorized_key { 'root':
    ensure  => present,
    type    => 'ssh-rsa',
    user    => 'root',
    require => File['/root/.ssh/authorized_keys'],
    key     => hiera('ssh_key1'),
  }

  ssh_authorized_key { 'root@xcat.london.maxeler.com':
    ensure  => present,
    type    => 'ssh-rsa',
    user    => 'root',
    require => File['/root/.ssh/authorized_keys'],
    key     => hiera('ssh_key2'),
  }
}
