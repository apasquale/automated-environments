class profile::text-editors {
  $chocolateyPackageList = [
    # Text Editor
    'sublimetext3',
    'SublimeText3.PackageControl',
    'notepadplusplus',
    # 'vim',    
  ]
  
  package { $chocolateyPackageList:
    ensure    => latest,
    provider  => 'chocolatey',
    require   => Exec['Install-Chocolatey'],
  }
}