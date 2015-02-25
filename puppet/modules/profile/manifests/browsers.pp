class profile::browsers {
  $chocolateyPackageList = [
    'GoogleChrome',
    'Firefox',
    'ChromeDriver2',
  ]

  package { $chocolateyPackageList:
    ensure    => latest,
    provider  => 'chocolatey',
    require   => Exec['Install-Chocolatey'],
  }
}