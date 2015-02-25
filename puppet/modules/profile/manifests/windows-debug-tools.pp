class profile::windows-debug-tools {
  $chocolateyPackageList = [
    # Windows debugging tools
    'Sysinternals',
    'fiddler4',
    'windbg',
  ]

  package { $chocolateyPackageList:
    ensure    => latest,
    provider  => 'chocolatey',
    require   => Exec['Install-Chocolatey'],
  }
}