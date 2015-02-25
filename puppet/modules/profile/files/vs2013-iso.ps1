param (
    [string] $IsoPath = "",
    [string] $IsoName = "en_visual_studio_professional_2013_with_update_4_x86_dvd_5935322.iso",
    [switch] $Silent = $true
)


function Install-VisualStudio
{
    [CmdletBinding()]
    param (
        [string] $ImagePath,
        [string[]] $ArgumentList,
        [string] $InstallPath,
        [string] $ProductKey,
        [string] $AdminFile,
        [switch] $Silent = $true
    )
    Write-Verbose "Installing Visual Studio..."
    
    $filePath = Join-Path $ImagePath "vs_*.exe" -Resolve
    $argumentList = @("/NoRestart","/Log c:\VSLogs\VisualStudio_Install.log", "/Passive")
 
    if(![String]::IsNullOrEmpty($InstallPath))
    {
        $argumentList +="/CustomInstallPath ${InstallPath}"
    }
    if(![String]::IsNullOrEmpty($ProductKey))
    {
        $argumentList +="/ProductKey ${ProductKey}"
    }

    if(![String]::IsNullOrEmpty($AdminFile)){
        $argumentList += "/adminfile ${AdminFile}"
    } else {
        $argumentList += "/Full"
    }

    if($Silent){
        $argumentList += "/quiet"
    }
    
    Write-Progress -Activity "Installing Visual Studio" -Status "Install..."
    Start-Process -FilePath $filePath -ArgumentList $ArgumentList  -Wait 
    Write-Progress -Activity "Installing Visual Studio" -Completed
}

Write-Host "Installing Visual Studio"

if($IsoPath) 
{
    $SqlImagePath = Join-Path $IsoPath $IsoName

    if(!(Test-Path -Path $IsoPath))
    {
        Write-Error "Cannot find Visual Studio install media in $IsoPath"
        throw
    }
}

$MountIsoPath = Join-Path -Path "C:\Windows\Temp\" -ChildPath $IsoName

if(-Not (Test-Path $MountIsoPath)) {
    # If copying from a shared folder
    # $srcPath = "C:\installMedia\vs\en_visual_studio_professional_2013_with_update_4_x86_dvd_5935322.iso"
    Write-Host "Copying iso from $IsoPath to $MountIsoPath"
    Copy-Item -Path $IsoPath -Destination $MountIsoPath
}

$rc = Mount-DiskImage -PassThru -ImagePath $MountIsoPath
$driveLetter = ($rc | Get-Volume).DriveLetter
Install-VisualStudio -ImagePath "${driveLetter}:" -AdminFile "C:\Windows\Temp\AdminDeployment.xml" -Silent $Silent

Dismount-DiskImage -ImagePath $MountIsoPath
Remove-Item -Force -Path $MountIsoPath

$key64 = 'HKLM:/SOFTWARE/Wow6432Node/Microsoft/VisualStudio/12.0'
$key32 = 'HKLM:/SOFTWARE/Microsoft/VisualStudio/12.0'

$installDir32Path = (Get-ItemProperty -Path $key32 -Name InstallDir -ErrorAction SilentlyContinue)
if(!$installDir32Path) {
    $installDir64 = (Get-ItemProperty -Path $key64 -Name InstallDir).InstallDir
    $installDirValue = $installDir64
}
else{
    $installDirValue = $installDir32.InstallDir
}

Write-Host "Pinning Visual Studio to the TaskBar"
$shell = new-object -com "Shell.Application"
$dir = $shell.Namespace("${installDirValue}")
$item = $dir.ParseName("devenv.exe")
$item.InvokeVerb('taskbarpin')