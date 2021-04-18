$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$artefact_name     = 'RPGMV_161W_Setup'
$url               = "https://dl.degica.com/rpgmakerweb/trial-download/$artefact_name.zip"
$url_checksum      = 'BA49006D64E05A69ED9681380F6A544ED01BDD9AE348C3663FE5423C38D31855'
$url_checksum_type = 'sha256'
$my_temp_dir       = "$env:temp\$env:ChocolateyPackageName"

#Get-ChocolateyWebFile -PackageName $env:ChocolateyPackageName -FileFullPath "$my_temp_dir\$env:ChocolateyPackageName.zip" -Url $url -Checksum $url_checksum -ChecksumType $url_checksum_type
#Get-ChocolateyUnzip   -PackageName $env:ChocolateyPackageName -FileFullPath "$my_temp_dir\$env:ChocolateyPackageName.zip" -Destination $my_temp_dir

Install-ChocolateyZipPackage -PackageName $env:ChocolateyPackageName -UnzipLocation "$my_temp_dir" -Url $url -Checksum $url_checksum -ChecksumType $url_checksum_type

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  url            = $url
  fileType       = 'exe'
  file           = "$my_temp_dir\$artefact_name\setup.exe"
  softwareName   = 'rpgmakermv-free-trial*'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs
