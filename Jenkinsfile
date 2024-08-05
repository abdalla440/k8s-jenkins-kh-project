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
            - name: deployer
              image: joshendriks/alpine-k8s
              command:
              - /bin/cat
              tty: true       
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

    // stage('Kaniko Build & Push Image') {
    //   steps {
    //     container('kaniko') {
    //       script {
    //         sh '''
    //         /kaniko/executor --dockerfile google-dino-game/Dockerfile --context google-dino-game --destination=ahannora440/google-dino
    //         '''
    //       }
    //     }
    //   }
    // }
    
    stage('Run kaniko') {
        steps {
            container('deployer') {
                sh '''
                echo "hello from deployer"
                '''
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
            // sh 'sed -i "s/<TAG>/${BUILD_NUMBER}/" web-app.yaml'
            sh '''
            curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
            unzip awscli-bundle.zip
            sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
            aws --version

            kubectl apply -f app-manifest-files/deployment.yaml'''
          }
        }
      }
    }
 
  }
}
