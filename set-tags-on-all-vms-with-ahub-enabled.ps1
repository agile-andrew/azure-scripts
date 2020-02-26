#################################################
# filename: "set-tags-on-all-vms-with-ahub-enabled.ps1"
# author: Andrew Penn
#
# Adds a tag to all VMs in the current scope with Azure Hybrid Use Benefit (AHUB) enabled.
# This tag can then be queried for in Cost Analysis to track costs of only AHUB-enabled VMs.
# At the time of this writing, Cost Analysis does not have native feature to filter VMs by AHUB status.
#
# NOTE: New Tags can take ~1 day to reflect in Cost Analysis before being queryable
#################################################

# Get all VMs in current scope
$allVms = Get-AzVm 

# Loop through all VMs
ForEach ($vm in $allVms) {
    
    # Azure Hybrid Use Benefit (AHUB) is enabled if the licensetype attribute is set to "Windows_Server" or "Windows_Client"
    # Check if AHUB is enabled
    if(($vm.LicenseType -eq "Windows_Server") -or ($vm.LicenseType -eq "Windows_Client")) {
    
        # Retrieve all of its current tags
        $tags = $vm.Tags
        
        # Append new tag
        $tags += @{"AHUB"="enabled"}
    
        # Set Tags to $tags with new tag appended
            # Force operation - no confirmation prompt by appending param -Force
            # Run cmdlet in background (no waiting for job to complete) by appending param -AsJob
        Set-AzResource -ResourceId $vm.id -Tag $tags -Force -AsJob
    }
}
