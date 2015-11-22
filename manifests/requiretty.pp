# Define: sudoers::requiretty
#
# This module manages sudo requiretty option
# for users and groups
#
define sudoers::requiretty(
  $requiretty       = false,
  $filename         = $title,
  $user             = undef,
  $group            = undef,
  $comment          = undef,
) {
  require ::sudoers

  if ($user == undef and $group == undef) {
    fail('must define user or group')
  }

  $requiretty_str = $requiretty ? {
    true  => 'requiretty',
    false => '!requiretty'
  }

  $user_spec = $group ? {
    undef   => $user,
    default => "%${group}"
  }

  file { "/etc/sudoers.d/${filename}":
    ensure  => file,
    content => validate(template('sudoers/requiretty.erb'), '/usr/sbin/visudo -cq -f'),
    mode    => '0440',
    owner   => root,
    group   => root,
  }
}
