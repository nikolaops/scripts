#!/bin/bash
echo "Enter your AWS profile cred name:"
read profile
echo "Aws region:"
read region
echo "Enter secret id (name):"
read secret

PS3="account: "

select opt in $(aws secretsmanager get-secret-value --secret-id $secret --profile $profile --region $region | jq --raw-output '.SecretString' | jq -r '. | keys[] as $k | "\($k) "')
do
aws secretsmanager get-secret-value --secret-id $secret --profile $profile --region $region | jq --raw-output '.SecretString' | jq -r .$opt
break
done