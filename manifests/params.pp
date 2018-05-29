# @summary
#   Params class.
#
# @api private
#
class powerdns_admin::params {
  $install_path           = '/opt/web/powerdns-admin'
  $virtualenv_path        = "${install_path}/flask"
  $requirements_path      = "${install_path}/requirements.txt"
  $config_path            = "${install_path}/config.py"
  $required_packages      =  ['libmariadbclient-dev',
                              'libsasl2-dev',
                              'libldap2-dev',
                              'libssl-dev',
                              'libxml2-dev',
                              'libxslt1-dev',
                              'libxmlsec1-dev',
                              'libffi-dev',
                              'pkg-config',
                              'git']
  $service_ensure         = 'running'
  $service_enable         = true
  $backend_install        = true
  $backend_create_tables  = true
  $db_root_password       = undef
  $db_password            = undef
  $log_level              = 'WARNING'
  $signup_enable          = false
  $pdns_api_key           = undef
  $pdns_api_url           = 'http://127.0.0.1:8081/'
  $app_secret_key         = fqdn_rand_string(20)
  $workers                = 1
  $python_version         = 3
}
