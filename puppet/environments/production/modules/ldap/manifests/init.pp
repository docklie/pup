# == class ldap
class { 'ldap': }

# ldap class
class ldap {
  include "ldap::${::operatingsystem}"
  include "ldap::${::lsbmajdistrelease}"
}
