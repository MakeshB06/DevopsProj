#!/bin/bash

if [[ $GIT_BRANCH == "origin/dev" ]]; then
    chmod +x ./build.sh
    ./build.sh
    docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
    docker tag react-app makeshb06/dev
    docker push makeshb06/dev

elif [[ $GIT_BRANCH == "origin/main" ]]; then
    chmod +x ./build.sh
    ./build.sh
    docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
    docker tag react-app makeshb06/prod
    docker push makeshb06/prod

else
    echo "Branch $GIT_BRANCH is not recognized. Exiting."
    exit 1
fi