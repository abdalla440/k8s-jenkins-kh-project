pipeline {

  options {
    ansiColor('xterm')
  }
  agent {
    kubernetes {
      yamlFile 'kubernetes_agent.yml'
    }

  }

  stages {

     stage('Kaniko Build & Push Image') {
       steps {
         container('kaniko') {
           script {
             sh '''
             /kaniko/executor --dockerfile google-dino-game/Dockerfile --context google-dino-game --destination=ahannora440/google-dino:${BUILD_NUMBER}
             '''
           }
         }
       }
     }
    
    stage('Deploy App to Kubernetes') {  
        environment {
                AWS_ACCESS_KEY_ID = credentials("aws_access_key_id")
                AWS_SECRET_ACCESS_KEY = credentials("aws_secret_access_key")
            } 

      steps {
        container('deployer') {
          withCredentials([file(credentialsId: 'kubeconfigscrt', variable: 'KUBECONFIG')]) {
            sh 'sed -i \"s|image:.*|image: ahannora440/google-dino:${BUILD_NUMBER}|g\" app-manifest-files/deployment.yaml'
            sh '''
            kubectl apply -f app-manifest-files'''
          }
        }
      }
    }
 
  }
}
