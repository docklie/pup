# declaring nx class
class { 'nx': }


# defining nx class

class nx {

    class {'nx::dir': } ->
    class {'nx::cprpm': } ->
    class {'nx::install': }
}


# declare class to create dir.

class nx::dir {

    file { '/root/nx/':
      ensure  => directory,
      mode    => '0775',
      owner   => 'root',
      group   => 'root',
  }
}


# declare class to copy rpm locally

class nx::cprpm {
    file { '/root/nx/nomachine_4.6.12_7_x86_64.rpm':
      mode    => '0664',
      owner   => 'puppet',
      group   => 'root',
      source  => 'puppet:///modules/nx/nomachine_4.6.12_7_x86_64.rpm',
  }
}


# declare install class

class nx::install {

      package { 'nomachine':
      ensure    => 'installed',
      provider  => 'rpm',
      source    => 'file:///root/nx/nomachine_4.6.12_7_x86_64.rpm',
  }
}



