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
    stage('Deploy to the Staging stack') {
      when {
        anyOf {
          branch 'master'
          buildingTag()
        }
      }
      steps {
        // Requires DOCKER_HOST be set in the Jenkins Configuration.
        // Using the environment variable enables this file to be
        // endpoint agnostic.
        sh "docker -H ${CNX_STAGING_DOCKER_HOST} service update --label-add 'git.commit-hash=${GIT_COMMIT}' --image openstax/cnx-webview:dev staging_ui"
        // Also cycle the http-cache (varnish), so we don't have stale pages being served
        sh "docker -H ${CNX_STAGING_DOCKER_HOST} service update --restart-condition=any staging_http-cache"
      }
    }
    stage('Run Functional Tests'){
      when {
        anyOf {
          branch 'master'
          buildingTag()
        }
      }
      steps {
          runCnxFunctionalTests(testingDomain: "${env.CNX_STAGING_DOCKER_HOST}")
      }
    }
    stage('Publish Release') {
      when { buildingTag() }
      environment {
        release = meta.version()
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
