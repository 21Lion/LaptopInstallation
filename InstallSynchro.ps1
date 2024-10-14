# Non-Interactive

Write-Host 'Using Chocolatey to install packages...'
# Define a list of packages to install with specific versions
$packages = @(
    @{ Name = "teamviewer"},
    @{ Name = "putty"},
    @{ Name = "MobaXTerm"}
)
# Install the specified packages
foreach ($package in $packages) {
    choco install $package.Name -y --ignore-checksums
}
Write-Host 'Checking for package updates...'
    choco upgrade all -y --ignore-checksums
Write-Host 'Chocolatey finished, installing missing packages...'

Write-Host 'Installing Ciena SiteManager...'
    & .\Ciena\SiteManager_windows-x64 /S /v/qn | Out-Null ;  
Write-Host 'Installing Ciena Calling Card...'
    & msiexec.exe /i 'Ciena\NetTech Partner Share Calling Card Link\LogMeIn Rescue Calling Card.msi' | Out-Null ;
Write-Host 'Installing ConnectorMax2...'
    & '.\ConnectorMax2\setup.exe' /quiet | Out-Null ;
#Write-Host 'Installing PuTTY...'
#    & msiexec.exe /i 'PuTTY\PuTTy_Installer.msi' /qn | Out-Null ;
#Write-Host 'Installing TeamViewer...'
#    & msiexec.exe /i 'TeamViewer\TeamViewer_Full.msi' /qn | Out-Null ;
Write-Host 'Installing Brady Workstation...'
    & '.\BWS-PWIDSuite\Setup.exe' /q | Out-Null ; 

# Interactive
Write-Host 'Installing Ciena Fast...'
    & .\Ciena\FASTSetup.exe | Out-Null ;
Write-Host 'Clearing Viavi FiberChekPro...'
    Start-Process  -FilePath 'C:\Program Files (x86)\Viavi\FiberChekPRO\unins000.exe' -ErrorAction SilentlyContinue | Out-Null ; 
Write-Host 'Installing Viavi Fiber Trace Viewer...' 
    & '.\VIAVI Fiber Apps\Fiber Trace Viewer\OFS-110_Optical_Fiber_Trace_Viewer_Software_Setup.exe' | Out-Null ; 
Write-Host 'Installing Viavi FiberChek Pro...'
    & '.\VIAVI Fiber Apps\FiberCheck Pro\fcpro_web_updater.exe' /SILENT | Out-Null ; 
Write-Host 'Installing Precision Transciever Tool as new user...'
    cp '.\Precision Optical\PrecisionTransceiverToolSetup.exe' -Destination 'C:\Users\Public\Downloads';
   