pipeline {

  options {
    ansiColor('xterm')
  }

  agent {
    kubernetes {
      yamlFile 'builder.yaml'
    }
  }

  stages {

    stage('Kaniko Build & Push Image') {
      steps {
        container('kaniko') {
          script {
            sh '''
            /kaniko/executor --dockerfile google-dino-game/Dockerfile --context google-dino-game  --destination=ahannora440/google-dino:${BUILD_NUMBER}
            '''
          }
        }
      }
    }

    stage('Deploy App to Kubernetes') {    
      steps {
        container('kubectl') {
          withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
            sh 'sed -i \"s|image:.*|image: ahannora440/google-dino:${BUILD_NUMBER}|g\" app-manifest-files/deployment.yaml'
            sh 'kubectl apply -f app-manifest-files'
          }
        }
      }
    }
 
  }
}