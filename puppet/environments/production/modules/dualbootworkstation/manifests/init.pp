# declare dualbootworkstation class
class { 'dualbootworkstation': }

# define dualbootworkstation class
class dualbootworkstation {
  include ::workstation
  include nvidia
}
