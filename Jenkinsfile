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
        
        stage('Git Checkout') {
            steps {
                git credentialsId: 'git_credentials',
                    url: 'https://github.com/ron025533/triangle-app.git'
            }
        }

        stage('Build the application') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Unit Test Execution') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t aaronandrianarivony/triangle-app:1.0.0 .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'dockerhubpass',
                                        variable: 'dockerHubPass')]) {
                    sh 'docker login -u aaronandrianarivony -p $dockerHubPass'
                    sh 'docker push aaronandrianarivony/triangle-app:1.0.0'
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