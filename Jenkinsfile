pipeline {
  agent any

  options {
    timeout(time: 5, unit: 'MINUTES')
  }

  environment {
    ARTIFACT_ID = "elbuo8/webapp:latest"
  }

  stages {
    stage('Build') {
        agent {
            docker {
                label 'docker'
                image 'node:11-alpine'
                args '--name docker-node'
            }
        }
      steps {
        script {
          dir("webapp") {
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
        branch 'master'
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
        build job: 'deploy-webapp-staging', parameters: [string(name: 'ARTIFACT_ID', value: "${env.ARTIFACT_ID}")], wait: false
      }
    }
  }
}
