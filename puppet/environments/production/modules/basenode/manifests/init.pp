# declare basenode class
class { 'basenode': }

# define basenode class. this contains the baselevel machine build
class basenode {

  include ldap
  include fstab
  include ntp::client
  include ssh::authorized_key
  include puppet
  include branding
  include sudo
  include syslogremote
  include yum
  include ncurseslib
  include nx
}
