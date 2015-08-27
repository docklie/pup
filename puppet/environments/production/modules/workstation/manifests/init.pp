# declare workstation class
class { 'workstation': }

# define workstaion class
class workstation {
  $ganglia_port = '8665'
  $ganglia_cluster = 'Workstation'
  include ::basenode
#  include ganglia::gmon
}
