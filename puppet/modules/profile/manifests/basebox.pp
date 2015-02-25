class profile::basebox {

  # Add extra chocolatey goodness here
  $chocolateyPackageList = [
	 	# Windows Utilities
    '7zip',
    'powershell4',
    'Jump-Location',
    'adobereader',
    'Cmder',    
  ]

  package { $chocolateyPackageList:
  	ensure	  => latest,
  	provider  => 'chocolatey',
  }
}