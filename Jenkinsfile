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
        imagename = "ahannora440/google-dino"
        dockerImage = ''
        containerName = 'dino-app'
        dockerHubCredentials = 'credentials-dockerhub'
    }
 
    agent any
 
    stages {
        stage('Cloning Git') {
            steps {
                git([url: 'https://github.com/GANESH0369/jenkins.git', branch: 'main'])
            }
        }
 
        stage('Building image') {
            steps {
                script {
                    dockerImage = docker.build "${imagename}:latest"
                }
            }
        }
 
        // stage('Running image') {
        //     steps {
        //         script {
        //             sh "docker run -d --name ${containerName} ${imagename}:latest"
        //             // Perform any additional steps needed while the container is running
        //         }
        //     }
        // }
 
        // stage('Stop and Remove Container') {
        //     steps {
        //         script {
        //             sh "docker stop ${containerName} || true"
        //             sh "docker rm ${containerName} || true"
        //         }
        //     }
        // }
 
        stage('Deploy Image') {
            steps {
                script {
                    // Use Jenkins credentials for Docker Hub login
                    withCredentials([usernamePassword(credentialsId: dockerHubCredentials, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
 
                        // Push the image
                        sh "docker push ${imagename}:latest"
                    }
                }
            }
        }
    }
}

// pipeline {
//   //
//   agent any
//   environment {
//     registry = 'ahannora440/google-dino'
//     registryCredential = 'credentials-dockerhub'
//     dockerImage = ''
//   }
//     stages {
//         stage('Clone Git Repository') {
//       steps {
//         git(
//                     url: 'https://github.com/abdalla440/k8s-jenkins-kh-project.git',
//                     branch: 'main',
//                     changelog: true,
//                     poll: true
//                 )
//       }
//         }

//         stage('Building image') {
//           steps {
//             script {
//               dockerImage = docker.build registry + ":$BUILD_NUMBER"
//             }
//           }
//         }
//         stage('Deploy image') {
//           steps {
//             script {
//               docker.withRegistry('', registryCredential) {
//                 dockerImage.push()
//               }
//             }
//           }
//         }
//         stage('Cleaning up') {
//           steps {
//             sh "docker rmi $registry:$BUILD_NUMBER"
//           }
//         }
//         }
// }
