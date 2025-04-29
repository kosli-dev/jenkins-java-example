FROM jenkins/jenkins:lts
# if we want to install via apt
USER root
RUN sh -c 'echo "deb [trusted=yes] https://apt.fury.io/kosli/ /"  > /etc/apt/sources.list.d/fury.list' && \
        apt install ca-certificates && \
        apt update && \
        apt install -y kosli vim


# install snyk
RUN curl --compressed https://downloads.snyk.io/cli/stable/snyk-linux-arm64 -o snyk && \
    chmod +x ./snyk && \
    mv ./snyk /usr/local/bin/

# install docker    
RUN apt update && curl -fsSL https://get.docker.com | sh
RUN usermod -aG docker jenkins

# drop back to the regular jenkins user - good practice
USER jenkins