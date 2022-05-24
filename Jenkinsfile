pipeline{
    environment {
        registry = "ahmedgrati/goviolin"
        registryCredential = 'dockerhub'
        dockerImage = ''
    }
   agent any
   stages{
         stage('SCM Checkout'){
                steps {
                    git branch: 'master', url: 'https://github.com/AhmedGrati/instabug-infra-challenge'
                }
            }
            stage('Verify Tools') {
                steps {
                    script {
                        sh '''
                            docker --version
                        '''
                    }
                }
            }
            stage('Build Docker Image') {
                steps{
                    script {
                        dockerImage = docker.build registry + ":latest"
                    }
                }
            }
            stage('Push Docker Image To DockerHub Registry') {
                steps{
                    script {
                        docker.withRegistry( '', registryCredential ) {
                            dockerImage.push()
                        }
                    }
                }
            }
    }
}