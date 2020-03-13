#!/bin/bash

# DISCLAIMER:
# THIS CODE-SAMPLE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, 
# INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
# This sample is not supported under any Microsoft standard support program or service. 
# The script is provided AS IS without warranty of any kind. Microsoft further disclaims all implied warranties including, 
# without limitation, any implied warranties of merchantability or of fitness for a particular purpose. The entire risk arising
# out of the use or performance of the sample and documentation remains with you. In no event shall Microsoft, its authors,
# or anyone else involved in the creation, production, or delivery of the script be liable for any damages whatsoever
# (including, without limitation, damages for loss of business profits, business interruption, loss of business information,
# or other pecuniary loss) arising out of the use of or inability to use the sample or documentation, even if Microsoft has
# been advised of the possibility of such damages, rising out of the use of or inability to use the sample script, even if Microsoft
# has been advised of the possibility of such damages.

# DEFINE CURRENT CONFIGURATION OF CONTAINER GROUP AS VARS
RESOURCEGRP="sftp-on-azure-rg"
ACICONTAINERGROUPNAME="sftp-group"
LOCATION="westus2"
IMAGE="atmoz/sftp:lastest"
RESTARTPOLICY="OnFailure"
CPU="2"
MEMORY="1"
OSTYPE="Linux"
IPADDR="Public"
PROTOCOL="TCP"
PORTS="22"
AZSTORAGEACCNAME="sftpstgjwuq7fvvcoqko"
AZSTORAGEACCKEY="RwxneUadJBDF5DqlzCxbkINoInjqS2IHhZVdqdCkFQyKtlBuVfuRcoi2lo/RPwHeHWweZhAxT9CUSWAa444NhQ=="
AZFILESHARENAME="sftpfileshare"
VOLUMEMOUNTPATHONCONTAINER="/home/anpenn/upload"
ENVVARS="'SFTP_USERS'='anpenn:Billgates01!:1001'"

# DEFINE NEW DNS LABEL TO ADD/UPDATE
NEWDNSNAMELABEL="mynewdnslabel"

# AZURE CLI COMMAND
az container create \
	-g $RESOURCEGRP \
	-n $ACICONTAINERGROUPNAME \
	--location $LOCATION \
	--image $IMAGE \
	--restart-policy $RESTARTPOLICY \
	--cpu $CPU \
	--memory $MEMORY \
	--os-type $OSTYPE \
	--ip-address $IPADDR \
	--protocol $PROTOCOL \
	--ports $PORTS \
  --azure-file-volume-account-name $AZSTORAGEACCNAME \
	--azure-file-volume-account-key $AZSTORAGEACCKEY \
	--azure-file-volume-share-name $AZFILESHARENAME \
	--azure-file-volume-mount-path $VOLUMEMOUNTPATHONCONTAINER \
	--environment-variables $ENVVARS \
	--dns-name-label $NEWDNSNAMELABEL
