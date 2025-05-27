#! /usr/bin/env bash

kosli create flow jenkins-java-example \
    --description "An example pipeline for a java project in jenkins." \
    --template-file ./scripts/jenkins-java-example-template.yml \
    --org kosli-public