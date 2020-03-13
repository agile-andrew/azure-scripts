# SFTP on Azure
## This script is about the SFTP on Azure deployment template using ACI located here: https://github.com/Azure-Samples/sftp-creation-template

### Problem
ACI does not have support for static IPs at the time of this writing. When an Azure container group is terminated,
it is likely that it will lose its current IP address and assume a new one. This is because a full restart or termination of any kind
is likely to replatform the container group onto new underlying hardware.

*This leads to an unreliable endpoint* Any apps that hardcode the dynamic IP address of the container group will break after
the container group terminates or restarts and assumes a new IP for any reason.

**Previous versions of the SFTP on Azure deployment template did not force creation of a FQDN to create a reliable endpoint. It does now
but that leaves all previous deployments using this template in a precarious state.**

### Solution
**This script uses an Azure CLI create command to update a deployed SFTP on Azure container group with a new or different FQDN.**

Rather than terminating and doing a full restart of the container, it instead does an in-place restart. In-place restarts do not replatform
the container group to new underlying hardware. This saves a significant amount of downtime during the redeployment process. 

### Disclaimer

**SYNOPSIS**
    Author:     Andrew Penn, MSFT
    Version:    1.0.0
    Created:    13/3/2020
    Updated:    13/3/2020
**NOTES**
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
