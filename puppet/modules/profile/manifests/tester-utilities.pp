class profile::tester-utilities {

  $chocolateyPackageList = [
	 	#Utilities
	 	'beyondcompare',
		'ansicon',
  ]

  package { $chocolateyPackageList:
  	ensure	  => latest,
  	provider  => 'chocolatey',
    require   => Exec['Install-Chocolatey'],
  }
}