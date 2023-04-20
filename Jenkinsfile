pipeline {
  agent any
  tools {
    nodejs '11.1.0'
  }

  options {
    timeout(time: 2, unit: 'MINUTES')
  }

  stages {
    stage('Install dependencies') {
      steps {
        sh 'cd jenkins-tests && npm i'
      }
    }
    stage('Run tests') {
      steps {
        sh 'cd jenkins-tests && npm t'
      }
    }
    stage('Run remote.') {
        build wait: false, job: 'parameterized', parameters: [string(name: 'ROOT_ID', value: '$BUILD_ID')]
    }
  }
}