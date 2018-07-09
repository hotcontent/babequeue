pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Image registry') {
            steps {
                sh """
                    #!/bin/bash

                    BRANCH="$(echo $1)"
                    docker build -f docker/Dockerfile.nginx -t babequeue_nginx:${BRANCH}
                """
            }
        }
        stage('Docker deploy') {
            steps {
                sh """
                   #!/bin/bash

                   BRANCH="$(echo $1)"
                   export BRANCH=$BRANCH
                   envsubst < "./docker-compose-test.yml" > "./docker-compose.yml"

                   docker-compose up -d -p babequeue_${BRANCH}
                   rm docker-compose.yml
                """
            }
        }
    }
}