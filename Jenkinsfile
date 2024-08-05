pipeline {

  options {
    ansiColor('xterm')
  }
  agent {
    kubernetes {
      yaml '''
        kind: Pod
        metadata:
            name: kaniko
            namespace: jenkins
        spec:
            serviceAccountName: jenkins-sa
            containers:   
            - name: kaniko
              image: gcr.io/kaniko-project/executor:debug
              command:
              - /busybox/cat
              tty: true
              volumeMounts:
                - name: docker-config
                  mountPath: /kaniko/.docker
            volumes:
              - name: docker-config
                secret:
                  secretName: docker-config

        
        '''
    }
  }
  stages {
    stage('Run kaniko') {
      steps {
        container('kaniko') {
          sh ' echo Hello World > hello.txt'
        }

      }
    }
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
  }
}