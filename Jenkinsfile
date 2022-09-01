pipeline{
    agent any
    stages {
        stage('Build Docker Image') {
            steps {
                sh "echo staring build the image"
                sh 'docker build -t viraj5132/krima:latest .'
            }
        }
        stage('Deploy Docker Image') {
            steps {
                sh "echo staring deploy the image"
                sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                sh 'docker push viraj5132/krima:latest'
            }
        }
        stage('Deploy to Kubernetes in green') {
              when { branch 'main'}
            steps {
                    sh "echo staring deploy the image in Kubernetes"
                    sh "scp -o StrictHostKeyChecking=no nodejs.yaml bluetraffic.sh ubuntu@$DEPLOY_IP:/home/ubuntu/"
                    sh "ssh ubuntu@$DEPLOY_IP kubectl rollout restart deployment green" 
            }
        }
        stage('Switch traffic in green') {
              when { branch 'main'}
            steps {
                    sh "echo staring switch traffic to blue"
                    sh "ssh ubuntu@$DEPLOY_IP \'chmod 777 bluetraffic.sh && ./bluetraffic.sh\'"
            }
        }
}
}
