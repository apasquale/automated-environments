param (
    [string] $IsoPath = "",
    [string] $IsoName = "en_sql_server_2014_developer_edition_x64_dvd_3940406.iso",
    [switch] $Silent = $true
)

function Install-SqlServer
{
    [CmdletBinding()]
    param (
        [string] $ImagePath,
        [string[]] $ArgumentList,
        [string] $InstallPath,
        [string] $ProductKey,
        [string] $ConfigFile,
        [switch] $Silent = $true,
        [switch] $AddUserName = $true
    )
    Write-Verbose "Installing Sql Server..."
    
    $filePath = Join-Path $ImagePath "setup.exe" -Resolve
    $argumentList = @("/Action=Install", "/IACCEPTSQLSERVERLICENSETERMS")
 
    if(![String]::IsNullOrEmpty($ConfigFile)){
        $argumentList += "/CONFIGURATIONFILE=${ConfigFile}"
    } 

    if($AddUserName) {
        $UserName = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
        $argumentList += "/SQLSYSADMINACCOUNTS=${UserName}"
    }

    if($Silent){
        $argumentList += "/Q"
    }
    
    Write-Progress -Activity "Installing Sql Server: $filePath" -Status "Install..."
    Write-Progress -Activity "Install arguments: $ArgumentList"
    Start-Process -FilePath $filePath -ArgumentList $ArgumentList  -Wait 
    Write-Progress -Activity "Installing Sql Server" -Completed
}

Write-Host "Installing Sql Server"

if($IsoPath)
{
    $SqlImagePath = Join-Path $IsoPath $IsoName

    if(-Not (Test-Path -Path $SqlImagePath))
    {
        Write-Error "Cannot find Sql Server install media in $SqlImagePath"
        throw
    }
}

$MountIsoPath = Join-Path -Path "C:\Windows\Temp\" -ChildPath $IsoName

if(-Not (Test-Path $MountIsoPath)) {
    # If copying from a shared folder
    Write-Host "Copying iso from $SqlImagePath to $MountIsoPath"
    Copy-Item -Path $SqlImagePath -Destination $MountIsoPath
}

$rc = Mount-DiskImage -PassThru -ImagePath $MountIsoPath
$driveLetter = ($rc | Get-Volume).DriveLetter
Install-SqlServer -ImagePath "${driveLetter}:" -ConfigFile "C:\Windows\Temp\ConfigurationFile.ini" -Silent $Silent

Dismount-DiskImage -ImagePath $MountIsoPath
Remove-Item -Force -Path $MountIsoPath

# TODO: Figure out how to find the install file to pin
# $key64 = 'HKLM:/SOFTWARE/Wow6432Node/Microsoft/SqlServer/12.0'
# $key32 = 'HKLM:/SOFTWARE/Microsoft/SqlServer/12.0'

# $installDir32Path = (Get-ItemProperty -Path $key32 -Name InstallDir -ErrorAction SilentlyContinue)
# if(!$installDir32Path) {
#     $installDir64 = (Get-ItemProperty -Path $key64 -Name InstallDir).InstallDir
#     $installDirValue = $installDir64
# }
# else{
#     $installDirValue = $installDir32.InstallDir
# }

# Write-Host "Pinning Sql Server to the TaskBar"
# $shell = new-object -com "Shell.Application"
# $dir = $shell.Namespace("${installDirValue}")
# $item = $dir.ParseName("devenv.exe")
# $item.InvokeVerb('taskbarpin')