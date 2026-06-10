pipeline {
    agent any

    tools {
        maven 'Maven3'
    }

    stages {

        stage('Git Checkout') {
            steps {
                git credentialsId: 'git_credentials',
                    url: 'https://github.com/TON_USERNAME_GITHUB/triangle-app.git'
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
                sh 'docker build -t TON_USERNAME_DOCKERHUB/triangle-app:1.0.0 .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'dockerhubpass',
                                        variable: 'dockerHubPass')]) {
                    sh 'docker login -u TON_USERNAME_DOCKERHUB -p $dockerHubPass'
                    sh 'docker push TON_USERNAME_DOCKERHUB/triangle-app:1.0.0'
                }
            }
        }
    }

    post {
        failure {
            emailext body: 'Ce Build $BUILD_NUMBER a echoue',
                     recipientProviders: [requestor()],
                     subject: 'Build echoue',
                     to: 'ton_email@gmail.com'
        }
    }
}