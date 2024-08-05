pipeline {
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
                - cat
                tty: true
        
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
  }
}