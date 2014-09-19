node 'default' {

  Exec {
    path => $::path
  }

  class {
    'mysql::server':
  }

  mysql::db {
    'pakiti2':
      user     => 'pakiti',
      password => 'password',
  } ->

  yumrepo {
    'pakiti':
      baseurl  => 'file:///vagrant/rpms',
      enabled  => 1,
      gpgcheck => 0,
  } ->

  class {
    'pakiti':
      server           => true,
      server_dbname    => 'pakiti2',
      server_username  => 'pakiti',
      server_password  => 'password',
      server_web_url   => $::fqdn,
      server_web_title => 'Pakiti service';
  }
}
