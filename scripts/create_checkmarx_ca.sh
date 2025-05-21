#! /usr/bin/env bash

kosli create attestation-type checkmarx-scan \
    --description "Checkmarx Scan." \
    --jq '.CriticalIssues == 0' \
    --jq '.HighIssues == 0' \
    --jq '.MediumIssues == 0' \
    --org kosli-public