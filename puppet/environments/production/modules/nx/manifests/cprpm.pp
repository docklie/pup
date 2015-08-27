# declare cprpm

class nx::cprpm {
    file { '/root/nx/nomachine_4.6.12_7_x86_64.rpm':
      mode    => '0664',
      owner   => 'puppet',
      group   => 'root',
      source  => 'puppet:///modules/nx/nomachine_4.6.12_7_x86_64.rpm',
#      require => 'nx::dir',
  }
}
