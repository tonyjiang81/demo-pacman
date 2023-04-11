#!/bin/bash

#set your parameters here, serial number should be your MFA arn, not user arn
serial_number='<arn:aws:iam::13143:mfa/JTTerUser>'
profile='default'

#input your authenticator code in the first parameter of command line
token_code=$1

echo $token_code
echo $serial_number
echo $profile

STSStr=`aws sts get-session-token --serial-number $serial_number --token-code $token_code --profile dev-get-token`

echo $STSStr

aws_access_key_id=`echo $STSStr | python3 -c "import sys, json; print(json.load(sys.stdin)['Credentials']['AccessKeyId'])"`
aws_secret_access_key=`echo $STSStr | python3 -c "import sys, json; print(json.load(sys.stdin)['Credentials']['SecretAccessKey'])"`
aws_session_token=`echo $STSStr | python3 -c "import sys, json; print(json.load(sys.stdin)['Credentials']['SessionToken'])"`

echo $aws_access_key_id
echo $aws_secret_access_key
echo $aws_session_token

aws configure set aws_access_key_id $aws_access_key_id --profile $profile
aws configure set aws_secret_access_key $aws_secret_access_key --profile $profile
aws configure set aws_session_token $aws_session_token --profile $profile
