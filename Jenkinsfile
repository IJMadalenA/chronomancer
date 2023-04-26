pipeline {
  agent any

  options {
    timeout(time: 2, unit: 'MINUTES')
  }

  environment {
    ARTIFACT_ID = "chronomancer-node:${env.BUILD_NUMBER}"
  }

  stages {
  stage('Install Docker') {
      steps {
        sh "pwd"
        sh "ls"
        sh "whoami"
        sh "chown jenkins ./install.sh"
        sh "ls"
        sh "./install.sh"
        echo "installation success."
      }
    }
    stage('Build') {
      steps {
        script {
          dir("chronomancer") {
            dockerImage = docker.build "${env.ARTIFACT_ID}"
          }
        }
      }
    }
    stage('Run tests') {
      steps {
        sh "docker run ${dockerImage.id} npm test"
      }
    }
    stage('Publish') {
      when {
        branch 'master '
      }
      steps {
        script {
          docker.withRegistry("", "DockerHubCredentials") {
            dockerImage.push()
          }
        }
      }
    }
    stage('Schedule Staging Deployment') {
      when {
        branch 'master'
      }
      steps {
        build job: 'deploy-chronomancer-staging', parameters: [string(name: 'ARTIFACT_ID', value: "${env.ARTIFACT_ID}")], wait: false
      }
    }
  }
}
