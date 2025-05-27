#! /usr/bin/env bash

kosli create attestation-type checkmarx-scan \
    --description "Checkmarx Scan." \
    --jq '.CriticalIssues == 0' \
    --org kosli-public


kosli create attestation-type custom-snyk-scan \
    --description "Custom Snyk Scan." \
    --schema ./scripts/sarif-schema-2.1.0.json \
    --jq 'any(.runs[].results[]?; .level == "error") | not' \
    --org kosli-public