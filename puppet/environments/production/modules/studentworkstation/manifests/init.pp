# declare studentworkstation class
class { 'studentworkstation': }

# define studentworkstation class
class studentworkstation {
  include ::workstation
  include training::student
}
