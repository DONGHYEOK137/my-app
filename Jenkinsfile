pipeline {
    agent {
        kubernetes {
            yaml """
apiVersion: v1
kind: Pod
metadata:
  namespace: jenkins
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug
    imagePullPolicy: Always
    command:
    - sleep
    args:
    - infinity
    volumeMounts:
    - name: docker-config
      mountPath: /kaniko/.docker/config.json
      subPath: .dockerconfigjson
  volumes:
  - name: docker-config
    secret:
      secretName: regcred
"""
        }
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/DONGHYEOK137/my-app.git',
                    credentialsId: 'admin'
            }
        }

        stage('Set Image Tag') {
            steps {
                script {
                    env.DOCKER_IMAGE = "arjleun581/ci-cd:${BUILD_NUMBER}.0"
                    echo "Docker Image Tag set to ${env.DOCKER_IMAGE}"
                }
            }
        }

        stage('Build and Push with Kaniko') {
            steps {
                container('kaniko') {
                    script {
                        sh """
/kaniko/executor --context \$WORKSPACE \
--dockerfile \$WORKSPACE/Dockerfile \
--destination \$DOCKER_IMAGE
"""
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}

