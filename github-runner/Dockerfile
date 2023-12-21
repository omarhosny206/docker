FROM debian:bookworm-slim

ARG RUNNER_VERSION="2.311.0"
ENV GITHUB_USERNAME ""
ENV GITHUB_REPOSITORY ""
ENV GITHUB_PERSONAL_ACCESS_TOKEN ""
ENV RUNNER_NAME ""

RUN apt-get update && apt-get install -y sudo jq ca-certificates curl gnupg
RUN install -m 0755 -d /etc/apt/keyrings 

RUN useradd -m github && usermod -aG sudo github && echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER github

WORKDIR /actions-runner

RUN curl -Ls https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz | tar xz \
    && sudo ./bin/installdependencies.sh

COPY --chown=github:github ./entrypoint.sh  ./entrypoint.sh

RUN sudo chmod u+x ./entrypoint.sh

RUN sudo mkdir /work && sudo chown -R github:github /work

ENTRYPOINT ["./entrypoint.sh"]
