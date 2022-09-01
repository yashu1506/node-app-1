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
         stage('Deploy to Kubernetes in blue') {
              when { branch 'dev'}
            steps {           
                    sh "echo staring switch traffic to green"
                    sh "scp -o StrictHostKeyChecking=no nodejs2.yaml greentraffic.sh ubuntu@$DEPLOY_IP:/home/ubuntu/"
                    sh "ssh ubuntu@$DEPLOY_IP kubectl rollout restart deployment blue"              
            }
        }
        stage('Switch traffic in blue') {
              when { branch 'dev'}
            steps {
                    sh "echo staring deploy the image in Kubernetes"
                    sh "ssh ubuntu@$DEPLOY_IP\'chmod 777 greentraffic.sh && ./greentraffic.sh\'"
            }
        }
    
    }
}
