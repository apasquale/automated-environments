class profile::git-tools {
  $chocolateyPackageList = [
    # Git tools    
    'poshgit',
    'p4merge',
    'gitextensions',
    'psget',
    'SourceTree',
    'kdiff3'
  ]

  if $chocolateyCustomSource == undef and !("" in [$chocolateyCustomSource]) {
    $chocolateyCustomSource = 'c:/puppet/installMedia/packages/'
    # $chocolateyCustomSource = 'https://www.myget.org/F/ap-chocolatey-packages/'
  }

  $gitpkg = 'git.install'
  $credWinStore = 'git-credential-winstore'

  package { $gitpkg:
    ensure    => latest,
    provider  => 'chocolatey',
    require   => Exec['Install-Chocolatey'],
  } ->

  package { $credWinStore:
    ensure    => latest,
    provider  => 'chocolatey',
    source    => $chocolateyCustomSource,
    require   => Exec['Install-Chocolatey'],
  } ->

  package { $chocolateyPackageList:
    ensure    => latest,
    provider  => 'chocolatey',
    require   => Exec['Install-Chocolatey'],
  }
}