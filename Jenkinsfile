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
                    
                     docker.withRegistry('https://index.docker.io/v1/', 'ramyaashwin-dockerhub') {
                    
                        if (env.BRANCH_NAME == 'dev') {
                            sh 'docker tag react-app:dev ramyaashwin/dev:latest'
                            sh 'docker push ramyaashwin/dev:latest'
                        
                        } else if (env.BRANCH_NAME == 'main') {
                            sh 'docker tag react-app:main ramyaashwin/main:latest'
                            sh 'docker push ramyaashwin/main:latest'
                            
                        }
                    }
                }
            }
        }
        stage('Deploy to Server') {
            when {
                branch 'main'
            }
            steps {
                
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
