#!/bin/bash

# DEFINE CURRENT CONFIGURATION OF CONTAINER GROUP AS VARS
RESOURCEGRP="sftp-on-azure-rg"
ACICONTAINERGROUPNAME="sftp-group"
LOCATION="westus2"
IMAGE="atmoz/sftp:lastest"
RESTARTPOLICY="OnFailure"
CPU="2"
MEMORY="1"
OSTYPE="Linux"
IPADDR="Pubic"
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
