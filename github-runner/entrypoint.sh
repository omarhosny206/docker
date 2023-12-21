#!/bin/sh

registration_url="https://api.github.com/repos/${GITHUB_USERNAME}/${GITHUB_REPOSITORY}/actions/runners/registration-token"
echo "Requesting registration URL at '${registration_url}'"

payload=$(curl -sX POST -H "Authorization: token ${GITHUB_PERSONAL_ACCESS_TOKEN}" ${registration_url})
export RUNNER_TOKEN=$(echo $payload | jq .token --raw-output)

# Function to add 'github" user to docker group
add_user_to_docker_group() {
        sudo chmod 777 /var/run/docker.sock
        sudo groupadd -g 999 docker
        sudo usermod -aG docker ${USER}
}

# Function to configure the github self-hosted runner
configure_runner() {
    ./config.sh --url https://github.com/${GITHUB_USERNAME}/${GITHUB_REPOSITORY} --pat ${GITHUB_PERSONAL_ACCESS_TOKEN} --name ${RUNNER_NAME} --work "/work" --unattended --replace
}

# Function to remove the runner from github repo after the container is being stopped
remove() {
    ./config.sh remove --unattended --pat "${GITHUB_PERSONAL_ACCESS_TOKEN}"
}

add_user_to_docker_group
configure_runner

trap 'remove; exit 130' INT
trap 'remove; exit 143' TERM

./run.sh "$*" &

wait $!
