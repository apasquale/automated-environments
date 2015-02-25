class profile::ruby-packages {

  $chocolateyPackageList = [
	  # Ruby Tools
    'ruby',
    'ruby2.devkit',    
  ]
  
  if $chocolateyCustomSource == undef and !("" in [$chocolateyCustomSource]) {
    $chocolateyCustomSource = 'c:/puppet/installMedia/packages/'
    # $chocolateyCustomSource = 'https://www.myget.org/F/ap-chocolatey-packages/'
  }

  package { $chocolateyPackageList:
    ensure    => latest,
    provider  => 'chocolatey',
    source    => $chocolateyCustomSource,
    require   => Exec['Install-Chocolatey'],
  } ->
  
  package { 'RubyMine':
  	ensure	  => latest,
  	provider  => 'chocolatey',
    require   => Exec['Install-Chocolatey'],
  }
}