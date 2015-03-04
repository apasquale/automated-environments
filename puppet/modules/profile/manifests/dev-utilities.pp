class profile::dev-utilities {

  $chocolateyPackageList = [
	 	#Utilities
	 	'Gow',
		'linqpad',
    'nuget.commandline',
    'nugetpackageexplorer'
  ]

  package { $chocolateyPackageList:
  	ensure	  => latest,
  	provider  => 'chocolatey',
    require   => Exec['Install-Chocolatey'],
  }
}