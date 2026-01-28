pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'akhilkumar119/starbucks'
        DOCKER_TAG = 'latest'
        REGISTRY_CREDENTIALS = 'dockerhub-creds'
    }
    stages {
        stage("Checkout Git"){
            steps {
                checkout scm
            }
        }
        stage("Build Docker image"){
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
            }
        }
        stage("Push Docker image to Docker Hub"){
            steps {
                withDockerRegistry(credentialsId: "${REGISTRY_CREDENTIALS}", url: 'https://index.docker.io/v1/') {
                    sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                }
            }
        }
        stage("deploy to EC2 instance"){
            steps {
                sh "docker rm -f starbucks-container || true"
                sh "docker run -d --name starbucks-container -p 3000:3000 ${DOCKER_IMAGE}:${DOCKER_TAG}"
            }
        }
    }
    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully.'
        }
    }
}