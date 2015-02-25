# This package is useful for those running directly on their host OS

class profile::desktop-utilities {
  $chocolateyPackageList = [
    # Desktop Utilities
    'windirstat',
    'skype',
    'HipChat',
    'ccleaner',
    'dropbox',
  ]

  package { $chocolateyPackageList:
    ensure    => latest,
    provider  => 'chocolatey',
    require   => Exec['Install-Chocolatey'],
  }
}