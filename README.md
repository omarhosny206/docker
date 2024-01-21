# Docker Repository

![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![Node](https://img.shields.io/badge/Node.js-43853D?style=for-the-badge&logo=node.js&logoColor=white)

This repository contains Docker files for running multiple environments using a Dockerfile file.

## Usage

Clone this repository to your local machine:
```bash
git clone https://github.com/omarhosny206/docker.git
```

Go inside the repo's directory:
```bash
cd docker
```

Build the Docker image:
```bash
docker build -t image-name:tag -f file_name .
# e.g. docker build -t my-java17-app:v1 -f java17.maven.Dockerfile .
```

Run the Docker container:
```bash
docker run -d -p port-on-host:port-inside-container image-name:tag
# e.g. docker run -d -p 8080:8080 my-java17-app:v1
```

## Available images
- [Java 17 + Gradle](./java17.gradle.Dockerfile)
- [Java 17 + Maven](./java17.maven.Dockerfile)
- [Node 20 + JavaScript](./node20.js.Dockerfile)
- [Node 20 + TypeScript](./node20.ts.Dockerfile)
- [Python 3.10](./python310.Dockerfile)
- [GitHub self-hosted runner](./github-runner/Dockerfile)
