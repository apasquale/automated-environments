class profile::jetbrains {

  $chocolateyPackageList = [
    #Utilities
    'resharper',
    'dotPeek',
    'dotCover',
    'dotMemory',
    'dotTrace'  
  ]

  package { $chocolateyPackageList:
    ensure    => latest,
    provider  => 'chocolatey',
    require   => Exec['Install-Chocolatey'],
  }
}