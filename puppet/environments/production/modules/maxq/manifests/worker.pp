# maxq worker class
class maxq::worker {
  include maxq

  $manager = '10.249.9.1'
# no longer required
# $cores   = ${::processorcount}
#
# $cputype = $::processorcount ? {
#   '2'     =>  'dualcore',
#   '4'     =>  'quadcore',
#   '8'     =>  'octcore',
#   '16'    =>  'hexacore',
#   default =>  'hardcore',
#  }
# map max P/N to maxq tag
  $cardtypere = $::processorcount ? {
    '24412' => 'max2446c',
    '24414' => 'max24412c',
    '2116'  => 'max2116',
    '23312' => 'max2336',
    '3224'  => 'max3324',
    '3324'  => 'max3324',
    default => 'maxFIXMEc',
  }

  file { '/etc/maxq/worker.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/etc/maxq'],
  }
}
