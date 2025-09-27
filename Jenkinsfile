pipeline {
    agent { label 'Node-Linux' }

    tools {
        jdk 'Java-21'
        maven 'Maven'
    }

    environment {
        GIT_REPO = 'https://github.com/bharathsavadatti447/git_assignment_27092025.git'
        BRANCH = 'main'
        EMAIL_RECIPIENTS = 'bharath.savadatti447@gmail.com'
        CUSTOM_SRC = '.'  // Java files location
    }

    stages {

        stage('Clean Workspace') {
            steps {
                echo "Cleaning workspace..."
                deleteDir()
            }
        }

        stage('Checkout') {
            steps {
                echo "Cloning repository from GitHub..."
                git branch: "${BRANCH}",
                    url: "${GIT_REPO}",
                    credentialsId: 'github'
            }
        }

        stage('Build & Test') {
            steps {
                echo "Compiling and testing Maven project..."
                sh "mvn clean compile -Dproject.build.sourceDirectory=${CUSTOM_SRC}"
                sh "mvn test -Dproject.build.sourceDirectory=${CUSTOM_SRC}"
            }
        }
        stage('Package & Archive') {
            steps {
                echo "Packaging project and archiving JAR..."
                sh "mvn package -Dproject.build.sourceDirectory=${CUSTOM_SRC}"
                archiveArtifacts artifacts: 'target/*.jar', allowEmptyArchive: true
            }
        }

        stage('Lint') {
            steps {
                echo "Running lint checks..."
                // Example: sh "mvn checkstyle:check -Dproject.build.sourceDirectory=${CUSTOM_SRC}"
            }
        }
    }

    post {
        always {
            echo "Pipeline finished."
        }

        success {
            echo "Build succeeded!"
            emailext(
                subject: "Build Success: ${env.JOB_NAME} [#${env.BUILD_NUMBER}]",
                body: "<p>Build succeeded in job <b>${env.JOB_NAME}</b> [#${env.BUILD_NUMBER}]</p>",
                to: "${EMAIL_RECIPIENTS}"
            )
        }

        unstable {
            echo "Build marked as UNSTABLE!"
            emailext(
                subject: "Build Unstable: ${env.JOB_NAME} [#${env.BUILD_NUMBER}]",
                body: "<p>Build became <b>UNSTABLE</b> in job <b>${env.JOB_NAME}</b> [#${env.BUILD_NUMBER}]</p>",
                to: "${EMAIL_RECIPIENTS}"
            )
        }

        failure {
            echo "Build failed!"
            emailext(
                subject: "Build Failed: ${env.JOB_NAME} [#${env.BUILD_NUMBER}]",
                body: "<p>Build failed in job <b>${env.JOB_NAME}</b> [#${env.BUILD_NUMBER}]</p>",
                to: "${EMAIL_RECIPIENTS}"
            )
        }
    }
}
