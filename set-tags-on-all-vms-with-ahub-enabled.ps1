#################################################
filename: "set-tags-on-all-vms-with-ahub-enabled.ps1"
author: Andrew Penn

Adds a tag to all VMs in the current scope with Azure Hybrid Use Benefit (AHUB) enabled.
This tag can then be queried for in Cost Analysis to track costs of only AHUB-enabled VMs.
At the time of this writing, Cost Analysis does not have native feature to filter VMs by AHUB status.

#################################################

# Get all VMs in current scope
$allVms = Get-AzVm 

# Loop through all VMs
ForEach ($vm in $allVms) {
    
    # Azure Hybrid Use Benefit (AHUB) is enabled if the licensetype attribute is set to "Windows_Server" or "Windows_Client"
    # Check if AHUB is enabled
    if(($vm.LicenseType -eq "Windows_Server") -or ($vm.LicenseType -eq "Windows_Client")) {
    
        # Add a tag to the VM where {key="AHUB", value="enabled"}
        Set-AzureRmResource -ResourceId $vm.id -Tag @{"AHUB"="enabled"}
    }
}
