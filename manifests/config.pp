# @summary
#   Creates the powerdns-admin config.py and includes the mysql class.
#
# @api private
#
class powerdns_admin::config {

  include powerdns_admin::mysql

  $app_secret_key = fqdn_rand_string(20)

  file { $::powerdns_admin::config_path:
    ensure  => file,
    content => epp("${module_name}/config.py.epp"),
  }
}
