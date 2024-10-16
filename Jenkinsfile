pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('ramyaashwin-dockerhub')
        DOCKER_DEV_REPO = 'ramyaashwin/dev'
        DOCKER_PROD_REPO = 'ramyaashwin/prod'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: "${env.BRANCH_NAME}", url: 'https://github.com/ramyaPandian1/capstone-devops-build.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Building Docker image.
                    docker.build("react-app:${env.BRANCH_NAME}")
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    sh 'echo $DOCKER_HUB_CREDENTIALS' 
                    // Login to Docker Hub
                     docker.withRegistry('https://index.docker.io/v1/', 'ramyaashwin-dockerhub') {
                    //docker.withRegistry('https://index.docker.io/v1/', DOCKER_HUB_CREDENTIALS) {
                        if (env.BRANCH_NAME == 'dev') {
                            sh 'docker tag react-app:dev ramyaashwin/dev:latest'
                            sh 'docker push ramyaashwin/dev:latest'
                            //docker.image("react-app:${env.BRANCH_NAME}").tag("${DOCKER_DEV_REPO}:latest")
                            //docker.image("${DOCKER_DEV_REPO}:latest").push()
                            //docker.image("react-app:${env.BRANCH_NAME}").push("${DOCKER_DEV_REPO}:latest")
                        } else if (env.BRANCH_NAME == 'master') {
                            docker.image("react-app:${env.BRANCH_NAME}").push("master")
                        }
                    }
                }
            }
        }
        stage('Deploy to Server') {
            when {
                branch 'master'
            }
            steps {
                // Add deployment logic for production (for example, SSH to a server and pull image)
                sh './deploy.sh'
            }
        }
    }
    post {
        success {
        echo 'Build succeeded!'
    }
    failure {
        echo 'Build failed!'
    }
    }
}
