FROM jenkins/jenkins:lts
# if we want to install via apt
USER root
RUN sh -c 'echo "deb [trusted=yes] https://apt.fury.io/kosli/ /"  > /etc/apt/sources.list.d/fury.list' && \
        apt install ca-certificates && \
        apt update && \
        apt install kosli

# drop back to the regular jenkins user - good practice
USER jenkins