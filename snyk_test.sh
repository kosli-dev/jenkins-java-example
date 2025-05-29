#!/bin/sh

# Authenticate Snyk CLI (will prompt browser login if not already authenticated)
# snyk auth

# Run Snyk code test (outputs SARIF file, does not fail script on vulnerabilities)
snyk code test --all-projects --org=fb62bc04-1591-4937-9659-d37c77946dde --sarif-file-output=snyk-code-test.json || true

# Run Snyk open source test (does not fail script on vulnerabilities)
snyk test --all-projects --org=fb62bc04-1591-4937-9659-d37c77946dde || true