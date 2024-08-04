/* groovylint-disable NestedBlockDepth */
// // pipeline {

// //   agent any
// //   environment {
// //     DOCKERHUB_CREDENTIALS = credentials('dockerub-credentials')
// //   }
// //   // options {
// //   //   ansiColor('xterm')
// //   // }

// //   // agent {
// //   //   kubernetes {
// //   //     yamlFile 'builder.yaml'
// //   //   }
// //   // }

// //   stages {

// //     stage('Kaniko Build & Push Image') {
// //       steps {
// //         container('kaniko') {
// //           script {
// //             sh '''
// //             /kaniko/executor --dockerfile google-dino-game/Dockerfile --context google-dino-game  --destination=ahannora440/google-dino:${BUILD_NUMBER}
// //             '''
// //           }
// //         }
// //       }
// //     }

// //   }
// // }

// pipeline {
//     agent any
//     environment {
//     DOCKERHUB_CREDENTIALS = credentials('credentials-dockerhub')
//     }
//     stages {

//         // stage('Build docker image') {
//         //       steps {
//         //           sh 'echo "test1" '
//         //       }
//         // }

//         stage('Build docker image') {
//             steps {
//                 sh 'docker build -t ahannora440/google-dino:$BUILD_NUMBER .'
//             }
//         }
//         stage('login to dockerhub') {
//             steps{
//                 sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
//             }
//         }
//         stage('push image') {
//             steps{
//                 sh 'docker push ahannora440/google-dino:$BUILD_NUMBER'
//             }
//         }
// }
// post {
//         always {
//             sh 'docker logout'
//         }

//     }
// }

/* groovylint-disable-next-line CompileStatic */
pipeline {
  environment {
    registry = 'ahannora440/google-dino'
    registryCredential = 'credentials-dockerhub'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning our Git') {
      steps {
        git 'https://github.com/abdalla440/k8s-jenkins-kh-project.git'
      }
    }
    stage('Building our image') {
      steps {
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy our image') {
      steps {
        script {
          docker.withRegistry('', registryCredential) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Cleaning up') {
      steps {
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
}
