$deploymentshare = ## Specify DeploymentShare Local Path ##
$networkpath = ## Specify DeploymentShare Network Path ##
$sources = ## Specify Windows Install Files


Import-Module "C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1"

New-Item F:\Deployment\MDTBuildLab -ItemType Directory
New-PSDrive -Name "DS001" -PSProvider MDTProvider -Root "$deploymentshare" -Description MDTBuildLab -NetworkPath "$networkpath" -Verbose | Add-MDTPersistentDrive -Verbose
#New-SmbShare –Name MDTBuildLab$ –Path "$deploymentshare" –FullAccess EVERYONE


## Create Operating System Folder Structure ##

new-item -path "DS001:\Operating Systems" -enable "True" -Name "Windows 7" -Comments "" -ItemType "folder" -Verbose
new-item -path "DS001:\Operating Systems" -enable "True" -Name "Windows 10" -Comments "" -ItemType "folder" -Verbose
new-item -path "DS001:\Operating Systems" -enable "True" -Name "Windows Server 2012 R2" -Comments "" -ItemType "folder" -Verbose
new-item -path "DS001:\Operating Systems" -enable "True" -Name "Windows Server 2016" -Comments "" -ItemType "folder" -Verbose

## Import Operating Systems ##

#import-mdtoperatingsystem -path "DS001:\Operating Systems\Windows 10" -SourcePath "$sources\EN Windows 10 x64 v1607" -DestinationFolder "EN Windows 10 x64 v1607" -Verbose
#import-mdtoperatingsystem -path "DS001:\Operating Systems\Windows 10" -SourcePath "$sources\EN Windows 10 Enterprise x64 v1607" -DestinationFolder "EN Windows 10 Enterprise x64 v1607" -Verbose


## Import Applications ##



## Create Packages Folder Structure ##

new-item -path "DS001:\Packages" -enable "True" -Name "Windows 7 x64" -Comments "" -ItemType "folder" -Verbose
new-item -path "DS001:\Packages" -enable "True" -Name "Windows 10 x64 v1511" -Comments "" -ItemType "folder" -Verbose
new-item -path "DS001:\Packages" -enable "True" -Name "Windows 10 x64 v1607" -Comments "" -ItemType "folder" -Verbose
new-item -path "DS001:\Packages" -enable "True" -Name "Windows Server 2012 R2" -Comments "" -ItemType "folder" -Verbose


## Import OS Packages ##

#Import-MDTPackage -Path "DS001:\Packages\Windows 10 x64" -SourcePath "F:\Windows 10 x64 Updates" -Verbose


## Create Selection Profiles ##

new-item -path "DS001:\Selection Profiles" -enable "True" -Name "Windows 7 x64" -Comments "" -Definition "<SelectionProfile><Include path=`"Packages\Windows 7 x64`" /></SelectionProfile>" -ReadOnly "False" -Verbose
new-item -path "DS001:\Selection Profiles" -enable "True" -Name "Windows 10 x64 v1511" -Comments "" -Definition "<SelectionProfile><Include path=`"Packages\Windows 10 x64 v1511`" /></SelectionProfile>" -ReadOnly "False" -Verbose
new-item -path "DS001:\Selection Profiles" -enable "True" -Name "Windows 10 x64 v1607" -Comments "" -Definition "<SelectionProfile><Include path=`"Packages\Windows 10 x64 v1607`" /></SelectionProfile>" -ReadOnly "False" -Verbose
new-item -path "DS001:\Selection Profiles" -enable "True" -Name "Windows Server 2012 R2" -Comments "" -Definition "<SelectionProfile><Include path=`"Packages\Windows Server 2012 R2`" /></SelectionProfile>" -ReadOnly "False" -Verbose


## Copy Configuration Files ##

#Copy-Item $PSScriptRoot\Bootstrap.ini -Destination $deploymentshare\Control\Bootstrap.ini -Force -Verbose
#Copy-Item $PSScriptRoot\CustomSettings.ini -Destination $deploymentshare\Control\CustomSettings.ini -Force -Verbose


## Update DeploymentShare ##

Update-MDTDeploymentShare -Path "DS001:" -Verbose