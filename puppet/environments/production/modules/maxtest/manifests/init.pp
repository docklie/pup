# declare maxtest class
class { 'maxtest': }

# define maxtest class
class maxtest {
  include ::basenode
  $ganglia_port = '8668'
  $ganglia_cluster = 'Workstation'
  include ganglia::gmon
}
