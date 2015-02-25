class profile::vs-extensions {
  $chocolateyPackageList = [
    #VS Extensions
    'nuget.commandline',
    'MarkdownMode',
    'NugetPackageManagerForVisualStudio2013',
    'visualstudio2013-webessentials.vsix'    
  ]

  package { $chocolateyPackageList:
    ensure    => latest,
    provider  => 'chocolatey',
    require   => Exec['vs2013-iso.ps1'],
  }

  $myGetChocolateyPackageList = [
    #VS Extensions
    'gister',
    'multiedit',
    'powershelltools',
    'specflow',
    'vscommands.vs2013',
    'editorconfig',
    'sqlserverdatatools.2013',
    'powertools.vs2013'
    #'routingAssistant', # Changed my mind, this package seems too cpu intensive
  ]

  if $chocolateyCustomSource == undef and !("" in [$chocolateyCustomSource]) {
    $chocolateyCustomSource = 'c:/puppet/installMedia/packages/'
    # $chocolateyCustomSource = 'https://www.myget.org/F/ap-chocolatey-packages/'
  }

  package { $myGetChocolateyPackageList:
    ensure    => latest,
    provider  => 'chocolatey',
    source    => $chocolateyCustomSource,
    require   => Exec['vs2013-iso.ps1'],
  }
}