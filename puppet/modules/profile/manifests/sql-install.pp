class profile::sql-install {
  file { 'ConfigurationFile.ini':
    path                => "C:/Windows/Temp/ConfigurationFile.ini",
    ensure              => file,
    source              => "puppet:///modules/profile/ConfigurationFile.ini",
    source_permissions  => 'ignore'
  }

  file { 'sql2014install_script':
    path                => "C:/Windows/Temp/sql2014-iso.ps1",
    ensure              => file,
    source              => "puppet:///modules/profile/sql2014-iso.ps1",
    source_permissions  => 'ignore',
    require   					=> File['ConfigurationFile.ini'],
  }
  
  exec { 'sql2014-iso.ps1':
    command   => "powershell -executionpolicy remotesigned -file C:/Windows/Temp/sql2014-iso.ps1",
    provider  => powershell,
    onlyif    => 'if (Test-Path "$env:ProgramFiles/Microsoft Sql Server") { exit 1 }',
    logoutput => true,
    timeout   => 0,
    require   => [ File['sql2014install_script'], Dism['NetFx3'] ]
  }
}