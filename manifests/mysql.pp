# @summary
#   Installs and configures the mysql backend depending on backend_install and backend_create_tables.
#
# @api private
#
class powerdns_admin::mysql {

  if $::powerdns_admin::backend_install {
    # mysql database
    if ! defined(Class['::mysql::server']) {
      class { '::mysql::server':
        root_password      => $::powerdns_admin::db_root_password,
        create_root_my_cnf => true,
      }
    }

    if ! defined(Class['::mysql::server::account_security']) {
      class { '::mysql::server::account_security': }
    }
  }

  if $::powerdns_admin::backend_create_tables {
    mysql::db { 'powerdnsadmin':
      user     => 'pdnsadminuser',
      password => $::powerdns_admin::db_password,
      host     => '%',
      grant    => [ 'ALL' ],
    }
    exec { 'powerdns_admin-migration':
      command     => "${::powerdns_admin::virtualenv_path}/bin/python ${::powerdns_admin::install_path}/create_db.py",
      require     => [Mysql::Db['powerdnsadmin'],
                      Python::Requirements[$::powerdns_admin::requirements_path]],
      refreshonly => true,
    }
  }
}
