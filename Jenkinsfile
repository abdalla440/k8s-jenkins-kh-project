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

 
  }
}