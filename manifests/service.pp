# @summary
#   Private class for managing the powerdns-admin service
#
# @api private
#
class powerdns_admin::service {

  include ::systemd::systemctl::daemon_reload

  ensure_resources('file', {'/usr/lib/systemd/system' => { ensure => directory }})

  file { '/usr/lib/systemd/system/powerdns-admin.service':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp("${module_name}/powerdns-admin.service.epp"),
  } ~> Class['systemd::systemctl::daemon_reload']

  service {'powerdns-admin':
    ensure    => $::powerdns_admin::service_ensure,
    enable    => $::powerdns_admin::service_enable,
    subscribe => File['/usr/lib/systemd/system/powerdns-admin.service'],
  }

}
