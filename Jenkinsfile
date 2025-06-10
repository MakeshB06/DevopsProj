pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        DOCKER_IMAGE = "react-app"
    }

    stages {
        stage('Build & Push Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-hub-credentials', 
                    usernameVariable: 'DOCKER_USERNAME', 
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    script {
                        echo "Running deployment script..."
                        sh 'chmod +x deploy.sh'