class profile::vs-install {
  file { 'AdminDeployment.xml':
    path                => "C:/Windows/Temp/AdminDeployment.xml",
    ensure              => file,
    source              => "puppet:///modules/profile/AdminDeployment.xml",
    source_permissions  => 'ignore'
  }

  file { 'vs2013install_script':
    path                => "C:/Windows/Temp/vs2013-iso.ps1",
    ensure              => file,
    source              => "puppet:///modules/profile/vs2013-iso.ps1",
    source_permissions  => 'ignore',
    require   					=> File['AdminDeployment.xml'],
  }
  
  exec { 'vs2013-iso.ps1':
    command   => "powershell -executionpolicy remotesigned -file C:/Windows/Temp/vs2013-iso.ps1",
    provider  => powershell,
    onlyif    => 'if (Test-Path "HKCU:/Software/Microsoft/VisualStudio/12.0/General") { exit 1 }',
    logoutput => true,
    timeout   => 0,
    require   => File['vs2013install_script'],
  }
}