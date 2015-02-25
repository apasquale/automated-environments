class profile::chocolatey {
  # override the default 5 min timeout of Puppet's Exec type
  Exec { timeout => 1800 }

  # Sets the execution policy to RemoteSigned
  registry_value { 'HKLM\Software\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell\ExecutionPolicy':
    ensure    => present,
    type      => string,
    data      => 'RemoteSigned',
  } ->

  exec { 'Install-Chocolatey':
    command   => 'iex ((new-object net.webclient).DownloadString("https://chocolatey.org/install.ps1"))',
    unless    => 'if ((Get-command choco*) -ne $null) { exit 1 }',
    provider  => powershell,
  }
}