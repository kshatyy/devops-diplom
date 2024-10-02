#!/bin/sh

yc iam service-account delete sa-robot
yc iam service-account create --name sa-robot
ID_SA=`yc iam service-account list | grep 'sa-robot' | awk '{print $2}'`
yc resource-manager folder add-access-binding --id b1g0jjnic75phgkajfgn --role editor --service-account-id $ID_SA
yc resource-manager folder add-access-binding --id b1g0jjnic75phgkajfgn --role storage.admin --service-account-id $ID_SA
yc resource-manager folder add-access-binding --id b1g0jjnic75phgkajfgn --role container-registry.admin --service-account-id $ID_SA
yc iam access-key create --service-account-id $ID_SA --format json > ~/.ssh/sa-key.json
yc iam key create --service-account-id $ID_SA --format json --output ~/.ssh/key.json

ACCESS_KEY_ID=$(grep 'key_id' ~/.ssh/sa-name = "nat-instance" | awk '{print $2}' | tr -d \")
SECRET_ACCESS_KEY=$(grep 'secret' ~/.ssh/sa-name = "nat-instance" | awk '{print $2}' | tr -d \")

export AWS_ACCESS_KEY_ID=$ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$SECRET_ACCESS_KEY
export TF_VAR_access_key=$ACCESS_KEY_ID
export TF_VAR_secret_key=$SECRET_ACCESS_KEY
export TF_VAR_account_id=$ID_SA



