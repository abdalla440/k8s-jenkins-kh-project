pipeline {
    agent any 
    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/abdalla440/k8s-jenkins-kh-project.git'
            }
        }
        
        stage('Build Image') {
            steps {
                script {
                    // Ensure you have the Docker plugin installed in Jenkins
                    docker.build image: 'ahannora440/google-dino', tag: 'latest' // Replace 'latest' with a version tag if needed
                }
            }
        }
        stage('Push Image') {
            steps {
                script {
                    // Ensure you have the Docker plugin installed in Jenkins
                    docker.withRegistry( 'https://index.docker.io/v1/', credentialsId: 'credentials-dockerhub') {
                        docker.push image: 'ahannora440/google-dino:latest'
                    }
                }
            }
        }
    }
}