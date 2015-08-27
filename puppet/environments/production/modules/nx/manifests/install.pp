# declaring install class

class nx::install {

      package { 'nomachine':
#    package { 'nomachine_4.6.12_7_x86_64':
      ensure    => 'installed',
      provider  => 'rpm',
      source    => 'file:///root/nx/nomachine_4.6.12_7_x86_64.rpm',
  }
}
