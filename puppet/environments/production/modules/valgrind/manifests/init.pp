# declaration of valgrind class
class { 'valgrind': }

# definition of valgrind class
class valgrind {

  package { 'valgrind-devel':
    ensure => installed,
  }
}
