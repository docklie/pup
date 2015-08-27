# declare trainerworkstation class
class { 'trainerworkstation': }

# define trainerworkstation class
class trainerworkstation {
  include ::workstation
  include training::trainer
}
