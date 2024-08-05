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
            //   volumeMounts:
            //     - name: kaniko-secret
            //       mountPath: /kaniko/.docker
            // volumes:
            //   - name: kaniko-secret
            //     secret:
            //       secretName: regcred
            //       items:
            //         - key: .dockerconfigjson
            //           path: config.json
        
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
            /kaniko/executor --dockerfile app-manifest-files/Dockerfile \
                            --context app-manifest-files \
                            --destination=ahannora440/k8s-jenkins-kh-project:${BUILD_NUMBER}
            '''
          }
        }
      }
    }
  }
}