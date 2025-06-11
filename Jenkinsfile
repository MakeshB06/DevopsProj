pipeline {
    agent any

    environment {
        DOCKER_DEV_REPO = "yourdockerhubusername/dev"
        DOCKER_PROD_REPO = "yourdockerhubusername/prod"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    def imageName = env.BRANCH_NAME == 'master' ? "${DOCKER_PROD_REPO}" : "${DOCKER_DEV_REPO}"
                    sh "docker build -t ${imageName}:latest ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    script {
                        def imageName = env.BRANCH_NAME == 'master' ? "${DOCKER_PROD_REPO}" : "${DOCKER_DEV_REPO}"
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                        sh "docker push ${imageName}:latest"
                    }
                }
            }
        }
    }
}