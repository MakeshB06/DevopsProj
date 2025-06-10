#!/bin/bash

# Accept branch name as argument or fallback to env variable
BRANCH=${1:-$GIT_BRANCH}

# Function to build, tag, and push
deploy_to_dockerhub() {
  TAG=$1
  IMAGE_NAME="react-app"
  DOCKER_REPO="makeshb06/$TAG"

  echo "Building Docker image..."
  chmod +x ./build.sh
  ./build.sh

  echo "Logging in to Docker Hub..."
  docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD"

  echo "Tagging image as $DOCKER_REPO"
  docker tag $IMAGE_NAME $DOCKER_REPO

  echo "Pushing $DOCKER_REPO to Docker Hub..."
  docker push $DOCKER_REPO
}

case "$BRANCH" in
  origin/dev)
    deploy_to_dockerhub "dev"
    ;;
  origin/master)
    deploy_to_dockerhub "prod"
    ;;
  *)
    echo "Unsupported branch: $BRANCH"
    exit 1
    ;;
esac