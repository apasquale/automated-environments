class profile::win8-IIS-Feature {
  dism { 'IIS-WebServerRole':
    ensure => present,
    require   => Exec['Install-Chocolatey']
  } ->
  
  dism { 'IIS-WebServer':
    ensure  => present,
    require => Dism['IIS-WebServerRole'],
  }
}