class profile::dism {
  dism { 'TelnetClient':
    ensure => present
  } ->

  dism { 'NetFx3':
    ensure => present,
    all => true,
  }

  # Not sure if we should enable BitLocker or not
  # dism { 'BitLocker':
  #   ensure => present
  # } -> 
}