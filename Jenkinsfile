@Library('pipeline-library') _

pipeline {
  agent { label 'docker' }
  stages {
    stage('Build') {
      steps {
        sh "docker build --build-arg environment=prod -t openstax/cnx-webview:dev ."
      }
    }
    stage('Publish Dev Container') {
      when {
        anyOf {
          branch 'master'
          buildingTag()
        }
      }
      steps {
        // 'docker-registry' is defined in Jenkins under credentials
        withDockerRegistry([credentialsId: 'docker-registry', url: '']) {
          sh "docker push openstax/cnx-webview:dev"
        }
      }
    }
  }
}
