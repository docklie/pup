# Site.pp 
$ldap_server       ='ldap://ldap.office.maxeler.com/ ldap://ldap2.critical.maxeler.com/'
$ldap_base_dn      ='dc=maxeler,dc=com'
$nameserver        ='10.249.7.3'

######################################################################################
# set the order of classes to be installed
######################################################################################


stage {'one':
  before => Stage['two'],
}

stage {'two':
  before => Stage['three'],
}

stage {'three':
  before => Stage['main'],
}

class {'ldap':
  stage => 'one',
}

class {'fstab':
  stage => 'two',
}

class {'yum':
  stage => 'three',
}
