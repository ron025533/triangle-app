pipeline {
    agent any

    tools {
        maven 'Maven3'
    }

    stages {

        stage('Check Docker') {
            steps {
                bat 'docker --version'
            }
        }

        stage('Build the application') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Unit Test Execution') {
            steps {
                bat 'mvn test'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t triangle-app:1.0 .'
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                withCredentials([
                  string(
                      credentialsId: 'dockerhubpass',
                       variable: 'dockerHubPass'
                   )
              ]) {
                  bat '''
                    docker login -u aaronandrianarivonytt -p %dockerHubPass%
                    docker tag triangle-app:1.0 aaronandrianarivonytt/triangle-app:1.0
                    docker push aaronandrianarivonytt/triangle-app:1.0
                    '''
              }
            }
        }
    }

    post {
        failure {
            emailext body: 'Ce Build $BUILD_NUMBER a echoue',
                     recipientProviders: [requestor()],
                     subject: 'Build echoue',
                     to: 'ron.andraina@gmail.com'
        }
    }
}