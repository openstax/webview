@Library('pipeline-library') _

pipeline {
  agent { label 'docker' }
  environment {
    TESTING_CONTAINER_NAME = "webview-testing-${env.BUILD_ID}"
  }
  stages {
    stage('Build') {
      steps {
        sh "docker build --build-arg environment=prod -t openstax/cnx-webview:dev ."
      }
    }
    stage('Publish Dev Container') {
      steps {
        // 'docker-registry' is defined in Jenkins under credentials
        withDockerRegistry([credentialsId: 'docker-registry', url: '']) {
          sh "docker push openstax/cnx-webview:dev"
        }
      }
    }
    stage('Deploy to the Staging stack') {
      steps {
        // Requires DOCKER_HOST be set in the Jenkins Configuration.
        // Using the environment variable enables this file to be
        // endpoint agnostic.
        sh "docker -H ${CNX_STAGING_DOCKER_HOST} service update --label-add 'git.commit-hash=${GIT_COMMIT}' --image openstax/cnx-webview:dev staging_ui"
      }
    }
    stage('Run Functional Tests'){
      steps {
          runCnxFunctionalTests(testingDomain: "${env.CNX_STAGING_DOCKER_HOST}")
      }
    }
    stage('Publish Release') {
      when { buildingTag() }
      environment {
        release = """${sh(
          returnStdout: true,
          // Strip the `v` prefix
          script: 'bash -c \'echo ${TAG_NAME#v*}\''
        ).trim()}"""
      }
      steps {
        withDockerRegistry([credentialsId: 'docker-registry', url: '']) {
          sh "docker tag openstax/cnx-webview:dev openstax/cnx-webview:${release}"
          sh "docker tag openstax/cnx-webview:dev openstax/cnx-webview:latest"
          sh "docker push openstax/cnx-webview:${release}"
          sh "docker push openstax/cnx-webview:latest"
        }
      }
    }
  }
}
