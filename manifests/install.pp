# powerdns_admin::install
class powerdns_admin::install {

  ensure_packages($::powerdns_admin::required_packages, {'ensure' => 'present'})

  vcsrepo { $::powerdns_admin::install_path:
    ensure   => present,
    provider => git,
    source   => 'https://github.com/ngoduykhanh/PowerDNS-Admin.git',
    revision => '4daf6f72a75f406e93a622116ce1841b029efa54',
  }

  class { 'python' :
    version    => "python${::powerdns_admin::python_version}",
    pip        => 'present',
    dev        => 'present',
    virtualenv => 'present',
  }

  python::virtualenv { $::powerdns_admin::virtualenv_path:
    ensure  => present,
    version => $::powerdns_admin::python_version,
    cwd     => $::powerdns_admin::virtualenv_path,
    notify  => [Python::Requirements[$::powerdns_admin::requirements_path],
                Exec['powerdns_admin-migration']],
    require => Vcsrepo[$::powerdns_admin::install_path],
  }

  python::requirements { $::powerdns_admin::requirements_path:
    virtualenv => $::powerdns_admin::virtualenv_path,
    require    => Package[$::powerdns_admin::required_packages],
  }

}
