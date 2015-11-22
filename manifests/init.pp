# Class: sudoers
class sudoers {
  package { 'sudo':
    ensure => present,
  }
  file { '/etc/sudoers.d':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0750',
    require => Package['sudo'],
  }
  #exec {'add_sudo_include_d':
  #  command => '/bin/echo "## Read drop-in files from /etc/sudoers.d (the # here does not mean a comment)" >> /etc/sudoers && /bin/echo "#includedir /etc/sudoers.d" >> /etc/sudoers',
  #  unless  => '/bin/grep -q "^#includedir /etc/sudoers.d" /etc/sudoers',
  #  require => File['/etc/sudoers.d'],
  #}
  file_line { 'include_sudoersd':
    path => '/etc/sudoers',
    line => '#includedir /etc/sudoers.d',
  }
}
