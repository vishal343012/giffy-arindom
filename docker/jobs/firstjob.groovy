pipelineJob('job-dsl-plugin') {
  definition {
    steps {
        script {
            sh "pwd"
        }
    }
  }
}