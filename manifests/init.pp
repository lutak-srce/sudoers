#
# = Class: sudoers
#
class sudoers (
  $env_keep = [],
){

  package { 'sudo':
    ensure => present,
  }

  File {
    owner   => root,
    group   => root,
    require => Package['sudo'],
  }

  file { '/etc/sudoers.d':
    ensure => directory,
    mode   => '0750',
  }

  file_line { 'include_sudoersd':
    path => '/etc/sudoers',
    line => '#includedir /etc/sudoers.d',
  }

  file { '/etc/sudoers.d/env_keep':
    ensure  => file,
    mode    => '0440',
    content => template('sudoers/env_keep.erb'),
  }

  # autoload configs from zabbix::agent::configs from hiera
  $sudoers_allowed_commands = hiera_hash('sudoers::allowed_commands', {})
  create_resources(::sudoers::allowed_command, $sudoers_allowed_commands)

}
