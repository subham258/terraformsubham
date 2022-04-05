pipeline {
    agent any 
    stages {
        stage ('git clone') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/subham258/terraformsubham.git']]])
            }
        }
        stage ('terafform init') {
            steps {
                sh '''
                terraform init
                terraform plan --var-file=terraform.tfvars
                '''
            }

        }        
        stage ('terraform apply in gcp') {
            steps {
                sh 'teraform apply --var-file=terafform.tfvars --auto-approve'
            }
        } 
    }
}
