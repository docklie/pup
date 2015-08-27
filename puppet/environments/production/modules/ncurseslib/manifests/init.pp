# -- Class ncurseslib
class { 'ncurseslib': }


# ncurseslib class
class ncurseslib {
  if $lsbmajdistrelease == '5' {
    warning('not available for this version')
  }

  else  {
    package{'ncurses-libs.i686':
      ensure => installed
    }
  }
}
