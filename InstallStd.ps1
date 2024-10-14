Write-Host 'Installing Chocolatey...'

# Check if Chocolatey is already installed, and if not, install it
if (-not (Test-Path 'C:\ProgramData\chocolatey\choco.exe')) {
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Wait for Chocolatey to finish initializing
Start-Sleep -Seconds 5

Write-Host 'Using Chocolatey to install packages...'
# Define a list of packages to install with specific versions
$packages = @(
    @{ Name = "adobereader"},
    @{ Name = "googlechrome"},
    @{ Name = "microsoft-edge"},
    @{ Name = "zoom"},
    @{ Name = "notepadplusplus.install"},
    @{ Name = "7zip.install"},
    @{ Name = "office365business"},
    @{ Name = "microsoft-teams-new-bootstrapper"},
    @{ Name = "filezilla"},
    @{ Name = "googleearthpro"},
    @{ Name = "itunes"}
)
# Install the specified packages
foreach ($package in $packages) {
    choco install $package.Name -y --ignore-checksums
}
Write-Host 'Checking for package updates...'
    choco upgrade all -y --ignore-checksums
Write-Host 'Cleaning up caches...'
    pushd $env:temp\chocolatey
    ls . | ? { $_.Name -notmatch "choco" } | % { del -Recurse -Force $_ }
    popd
Write-Host 'Chocolatey finished, installing missing packages...'

# Install packages outside of choco
Write-Host 'Installing KnowBe4 Phish Alert...'
    & 'KnowBe4\PhishAlert\PhishAlertButtonSetup.exe' /q LicenseKey=LicenseKey ALLUSERS=1 | Out-Null ; 
	
Write-Host 'Installing MS Visio Viewer...'
    #& '.\Microsoft\Visio Viewer\visioviewer_4339-1001_x64_en-us.exe' /quiet | Out-Null ; 
    #& '.\Microsoft\Visio Viewer\vviewer2016-kb2920709-fullfile-x64-glb.exe' /quiet | Out-Null ; 
    & reg import '.\Microsoft\Visio Viewer\Visio_Viewer_in_Edge.reg' | Out-Null ;

Write-Host 'Installing FortiClient...'
    & msiexec.exe /i 'FortiClient\FortiClientVPN_xxx.msi' /qn REBOOT=ReallySuppress DONT_PROMPT_REBOOT=1 | Out-Null ; 
    $FCConfigPath = 'C:\Program Files\Fortinet\Forticlient\FCConfig.exe' ;
        if (Test-Path $FCConfigPath){
            & $FCConfigPath -m vpn -f 'FortiClient\vpn.conf' -o import
        }