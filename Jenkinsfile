pipeline {
    agent { label 'Node-Linux' }

    environment {
        GIT_REPO = 'https://github.com/bharathsavadatti447/javarepo.git'
        BRANCH   = 'main'
    }

    stages {
        stage('Clone') {
            steps {
                echo "Cloning the repo from Github ........."
                git branch: "${BRANCH}",
                    url: "${GIT_REPO}",
                    credentialsId: 'a5e5c631-8e24-48ee-9844-ea7c8b7a658d'
            }
        }

        stage('Build') {
            steps {
                sh 'chmod +x run_maven_project.sh'
                sh './run_maven_project.sh'
                archiveArtifacts artifacts: 'target/*.jar', allowEmptyArchive: true

            }
        }

        stage('Lint') {
            steps {
                echo "Running lint checks..."
                // Example: sh 'lint-tool build/'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished (success/failure/unstable).'
        }
        success {
            echo 'Build succeeded!'
            emailext(
                subject: "Build Success: ${env.JOB_NAME} [#${env.BUILD_NUMBER}]",
                body: """<p>Build succeeded in job <b>${env.JOB_NAME}</b> [#${env.BUILD_NUMBER}]</p>""",
                recipientProviders: [[$class: 'DevelopersRecipientProvider']],
                to: "bharath.savadatti447@gmail.com"
            )
        }
        unstable {
            echo 'Build marked as UNSTABLE!'
            emailext(
                subject: "Build Unstable: ${env.JOB_NAME} [#${env.BUILD_NUMBER}]",
                body: """<p>Build became <b>UNSTABLE</b> in job <b>${env.JOB_NAME}</b> [#${env.BUILD_NUMBER}]</p>""",
                recipientProviders: [[$class: 'DevelopersRecipientProvider']],
                to: "bharath.savadatti447@gmail.com"
            )
        }
        failure {
            echo 'Build failed!'
            emailext(
                subject: "Build Failed: ${env.JOB_NAME} [#${env.BUILD_NUMBER}]",
                body: """<p>Build failed in job <b>${env.JOB_NAME}</b> [#${env.BUILD_NUMBER}]</p>""",
                recipientProviders: [[$class: 'DevelopersRecipientProvider']],
                to: "bharath.savadatti447@gmail.com"
            )
        }
    }
}
