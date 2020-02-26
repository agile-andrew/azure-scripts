<#
.SYNOPSIS
    Author:     Andrew Penn, MSFT
    Version:    1.0.0
    Created:    26/2/2020
    Updated:    26/2/2020

.DESCRIPTION
    This script automates the process of applying a tag to all Virtual Machines in the current scope
    with Azure Hybrid Use Benefit (AHUB) enabled.
    
    These tags can then be queried for in Cost Analysis to track costs of only AHUB-enabled VMs.
    At the time of this writing, Cost Analysis does not have native capability to filter VMs by AHUB status.
    
    Note that new Tags can take 1 day to reflect in Cost Analysis before being queryable.

.NOTES
    THIS CODE-SAMPLE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED 
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR 
    FITNESS FOR A PARTICULAR PURPOSE.

    This sample is not supported under any Microsoft standard support program or service. 
    The script is provided AS IS without warranty of any kind. Microsoft further disclaims all
    implied warranties including, without limitation, any implied warranties of merchantability
    or of fitness for a particular purpose. The entire risk arising out of the use or performance
    of the sample and documentation remains with you. In no event shall Microsoft, its authors,
    or anyone else involved in the creation, production, or delivery of the script be liable for 
    any damages whatsoever (including, without limitation, damages for loss of business profits, 
    business interruption, loss of business information, or other pecuniary loss) arising out of 
    the use of or inability to use the sample or documentation, even if Microsoft has been advised 
    of the possibility of such damages, rising out of the use of or inability to use the sample script, 
    even if Microsoft has been advised of the possibility of such damages. 

#>

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
