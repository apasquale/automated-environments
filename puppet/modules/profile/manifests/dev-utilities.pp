class profile::dev-utilities {

  $chocolateyPackageList = [
	 	#Utilities
	 	'Gow',
		'linqpad'		
  ]

  package { $chocolateyPackageList:
  	ensure	  => latest,
  	provider  => 'chocolatey',
    require   => Exec['Install-Chocolatey'],
  }
}