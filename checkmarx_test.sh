#!/bin/sh

export CX_REFRESH_TOKEN="REFRESH TOKEN HERE"

response=$(curl -X POST \
    https://deu.iam.checkmarx.net/auth/realms/kosli-nfr/protocol/openid-connect/token \
    --data "grant_type=refresh_token" \
    --data "client_id=ast-app" \
    --data "refresh_token=${CX_REFRESH_TOKEN}")

access_token=$(echo $response | jq -r '.access_token')

# curl --request GET \
#   https://deu.ast.checkmarx.net/api/projects/ \
#   --header 'Accept: application/json; version=1.0' \
#   --header "Authorization: Bearer ${access_token}" \
#   --header 'CorrelationId: '

curl --request POST \
    https://deu.ast.checkmarx.net/api/scans/ \
    --header 'Accept: application/json; version=1.0' \
    --header "Authorization: Bearer ${access_token}" \
    --header 'Content-Type: application/json; version=1.0' \
    --data '{ \
    "type": "git", \
    "project": { \
        "id": "kosli-dev/jenkins-java-example" \
    }, \
    "config": [ \
        { \
        "type": "sca", \
        "value": { \
            "incremental": "true", \
            "presetName": "Default" \
        } \
        } \
    ] \
}'