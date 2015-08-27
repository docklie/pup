# declare class to create dir.

class nx::dir {

    file { '/root/nx/':
      ensure  => directory,
      mode    => '0775',
      owner   => 'root',
      group   => 'root',
  }
}
