properties([pipelineTriggers([githubPush()])])

pipeline {
    agent any

    tools {
        flutter "flutter"
    }
        
    stages {
        stage('Run') {
            steps {
                git url:'git@github.com:PayeTonKawa/ApplicationMobile.git', 
                    credentialsId: 'GitSSH', 
                    branch:'main'
                sh "cd "
            }
        }
        stage('Build') {
            steps {
                sh "flutter build apk"
            } 
        }
        stage('Tests') {
            steps {
                sh "flutter --test coverage"
                archiveArtifacts artifacts: 'lcov.info', fingerprint: true
            }
        }
    post { 
        always { 
            cleanWs()
        }
    }
}
