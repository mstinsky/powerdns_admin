# @summary
#   Install and configure PowerDNS-Admin
# @example Install PowerDNS-Admin
#   class { '::powerdns_admin':
#     db_root_password => 'strongpassword',
#     db_password      => 'strongpassword',
#     pdns_api_key     => 'my_api_key',
#   }
#
# @param install_path
#   The path to which powerDNS-Admin is going to be installed to. Defaults to `/opt/web/powerdns-admin`.
# @param virtualenv_path
#   The path where the virtualenv is going to be build. Defaults to `/opt/web/powerdns-admin/flask`.
# @param requirements_path
#   The path where the requirements.txt is located. Defaults to `/opt/web/powerdns-admin/requirements.txt`.
# @param config_path
#   The path where the config.py is located. Defaults to `/opt/web/powerdns-admin/config.py`
# @param required_packages
#   Array of packages that are required for powerDNS-Admin to work.
# @param service_ensure
#   Specifies wether the service should be running or stopped. Valid values are `running`, `stopped`. Defaults to `running`.
# @param service_enable
#   Specifies whether the service should be enabled. Valid values are `true`, `false`. Defaults to `true`.
# @param backend_install
#   Specifies wether the mysql backend should be installed by this module. Defaults to `true`.
# @param backend_create_tables
#   Specifies wether this module should do the database migration. Defaults to `true`.
# @param db_root_password
#   Specifies the database root password when backend_install is used. Defaults to `undef`.
# @param db_password
#   Specifes the database password for powerdnsadmin. Defaults to `undef`.
# @param log_level
#   Specifies the log_level of PowerDNS-Admin. Defaults to `WARNING`.
# @param signup_enable
#   Specifies if user can create accounts on the login screen. Defaults to `false`.
# @param pdns_api_key
#   Specifies the powerdns api key needed to access to rest api. Defaults to `undef`.
# @param pdns_api_url
#   Specifies the url to the powerdns api. Defaults to `http://127.0.0.1:8081/`
# @param workers
#   Specifies how many workers should be started. Defaults to `1`.
# @param python_version
#   Specifies which python version should be used. Defaults to `3`.
class powerdns_admin(
  String[1]                  $install_path,
  String[1]                  $virtualenv_path,
  String[1]                  $requirements_path,
  String[1]                  $config_path,
  Optional[Array[String[1]]] $required_packages,
  Enum['running', 'stopped'] $service_ensure,
  Boolean                    $service_enable,
  Boolean                    $backend_install,
  Boolean                    $backend_create_tables,
  Optional[String[1]]        $db_root_password,
  Optional[String[1]]        $db_password,
  String[1]                  $log_level,
  Boolean                    $signup_enable,
  Optional[String[1]]        $pdns_api_key,
  Optional[String[1]]        $pdns_api_url,
  Integer[1]                 $workers,
  Integer[2]                 $python_version,
  ) {

  $app_secret_key = fqdn_rand_string(20)

  contain powerdns_admin::install
  contain powerdns_admin::config
  contain powerdns_admin::service
  Class['::powerdns_admin::install']
  -> Class['::powerdns_admin::config']
  ~> Class['::powerdns_admin::service']
}
