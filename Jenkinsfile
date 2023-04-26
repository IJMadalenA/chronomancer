pipeline {
  agent any

  options {
    timeout(time: 2, unit: 'MINUTES')
  }

  environment {
    ARTIFACT_ID = "chronomancer-node"
  }

  stages {
    stage('Build') {
      steps {
        script {
          dir(".") {
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
