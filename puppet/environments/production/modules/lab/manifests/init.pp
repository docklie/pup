# declare lab class
class { 'lab': }

#define lab class
class lab {
  $ups_time = '20'
  $ganglia_port = '8667'
  $ganglia_cluster = 'Lab'
  include basenode
  include ganglia::gmon
  include valgrind
  include ups
}
