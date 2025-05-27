#!/bin/sh

export CX_REFRESH_TOKEN="TOKEN"

response=$(curl -X POST \
    https://deu.iam.checkmarx.net/auth/realms/kosli-nfr/protocol/openid-connect/token \
    --data "grant_type=refresh_token" \
    --data "client_id=ast-app" \
    --data "refresh_token=${CX_REFRESH_TOKEN}")

accessToken=$(echo $response | jq -r '.access_token')

# curl --request GET \
#   https://deu.ast.checkmarx.net/api/projects/ \
#   --header 'Accept: application/json; version=1.0' \
#   --header "Authorization: Bearer ${accessToken}" \
#   --header 'CorrelationId: ' | jq .

# curl --request POST \
#     https://deu.ast.checkmarx.net/api/scans/ \
#     --header 'Accept: application/json' \
#     --header "Authorization: Bearer ${accessToken}" \
#     --header 'Content-Type: application/json; version=1.0' \
#     --data '{
#         "project": { 
#             "id": "0af76263-3d75-482c-ae9e-171b7d046e7c" 
#         },
#         "type": "git",
#         "handler": {
#             "repoUrl": "https://github.com/kosli-dev/jenkins-java-example",
#             "branch": "develop"
#         },
#         "config": [
#             {
#                 "type": "sast",
#                 "value": {
#                     "incremental": "false",
#                     "presetName": "All"
#                 }
#             }
#         ]
#     }'

baseScanId="eaa79f5d-b5c2-4cd8-b399-05fb782c1ff7"
# scanId="8f55d125-a813-4a5f-beb6-23cd3e108547"
sastScanId="791e17cc-ea29-459e-a775-a78fbde1e5ce"
scanId=$sastScanId

# # # Get scan status
# curl --request GET \
#     --url https://deu.ast.checkmarx.net/api/scans/${scanId} \
#     --header 'Accept: application/json; version=1.0' \
#     --header "Authorization: Bearer ${accessToken}" | jq .

# # Get detailed scan results
# curl --request GET \
#     --url https://deu.ast.checkmarx.net/api/results?scan-id=${scanId} \
#     --header 'Accept: application/json; version=1.0' \
#     --header "Authorization: Bearer ${accessToken}" | jq .

# Get detailed SAST scan results and check status
result=$(curl --silent --request GET \
    --url "https://deu.ast.checkmarx.net/api/sast-results/compare?scan-id=${scanId}&base-scan-id=${baseScanId}" \
    --header 'Accept: application/json; version=1.0' \
    --header "Authorization: Bearer ${accessToken}")

status=$(echo "$result" | jq -r '.status')

if [ "$status" = "RECURRENT" ] || [ "$status" = "FIXED" ]; then
    echo "true"
else
    echo "false"
fi
