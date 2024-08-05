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
              image: abanobmorkos10/aws-kubectl
              command:
              - /bin/bash
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
            sh 'sed -i \"s|image:.*|image: ahannora440/google-dino:${BUILD_NUMBER}|g\" app-manifest-files/deployment.yaml'
            sh '''
            kubectl apply -f app-manifest-files'''
          }
        }
      }
    }
 
  }
}
