# declare yum. This class adds the epel repo (external) to the system. gpgchecks are disabled.
class { 'yum': }

# define yum
  class yum {
    case $::operatingsystemrelease {
      default: {}
      /^5.*/: {
        file { 'epel5.repo':
          ensure  => file,
          mode    => '0644',
          path    => '/etc/yum.repos.d/epel.repo',
          owner   => 'root',
          group   => 'root',
          source  => 'puppet:///modules/yum/epel5/epel.repo',
         # require => [Package['epel-release']],
      }
    }  
      /^6.*/: {
        file { '/etc/yum.repos.d/epel.repo':
          ensure  => file,
          mode    => '0644',
          owner   => 'root',
          group   => 'root',
          source  => 'puppet:///modules/yum/epel.repo',
          require => [Package['epel-release']],
    }

#install rpm depending on major version
# NB: has not been tested with CentOS 5 ############################
    case $::operatingsystemrelease {
      default: {}
      /^5.*/: {
        package { 'epel-release':
          ensure   => present,
          provider => 'rpm',
          source   => 'http://dl.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm',
        }
      }

      /^6.*/: {
        package { 'epel-release':
          ensure   => present,
          provider => 'rpm',
          source   => 'http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm',
          }
        }
      }
    }
  }
}
