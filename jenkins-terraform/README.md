pipeline {
    agent any
    options {disableConcurrentBuilds()}
    environment {
        GOOGLE_PROJECT_ID = "creating-and-150-e882c01b" 
        GOOGLE_PROJECT_NAME = "creating-and-150-e882c01b"
        GOOGLE_APPLICATION_CREDENTIALS = credentials('sc_jenkins_terraform')
        GOOGLE_CLOUD_KEYFILE_JSON = credentials('sc_jenkins_terraform')
    }
    parameters { 
      choice(name: 'ENTORNOS', choices: ['dev', 'pre', 'pro'], description: 'Seleccione el entorno a utilizar')
      choice(name: 'ACCION', choices: ['', 'plan-apply', 'destroy'], description: 'Seleccione el entorno a utilizar')
    }
    stages{
        
        stage('clean workspaces -----------') { 
            steps {
              cleanWs()
              sh 'env'
            } //steps
        }  //stage

        //${params.Acción}
        stage("git clone code terraform"){
            steps {
                cleanWs()             
                    checkout([$class: 'GitSCM', 
                    branches: [[name: '*/main']], 
                    extensions: [], 
                    userRemoteConfigs: [[url: 'https://github.com/luismendezescobar/jenkins_course.git']]])


                sh 'pwd' 
                sh 'ls -l'
            } //steps
        }  //stage
    
        stage('Terraform init----') {
         steps {
            sh 'terraform --version'
            //sh ' cd jenkins-terraform/bastion && gcloud projects list'
            sh ' cd jenkins-terraform/bastion '
            sh ' cd jenkins-terraform/bastion && terraform init -var-file="dev.tfvars" '
            } //steps
        }  //stage

        stage('Terraform plan----') {
            steps {
               sh 'cd jenkins-terraform/bastion && terraform plan  -refresh=true  -var-file="dev.tfvars" -lock=false'
            } //steps
        }  //stage
        
        stage('Confirmación de accion') {
            steps {
                script {
                    def userInput = input(id: 'confirm', message: params.ACCION + '?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
                }
            }
        }
        
        stage('Terraform apply or destroy ----------------') {
            steps {
               sh 'echo "comienza"'
            script{  
                if (params.ACCION == "destroy"){
                         sh ' echo "llego" + params.ACCION'   
                         sh 'cd jenkins-terraform/bastion && terraform destroy -var-file="dev.tfvars" -auto-approve'
                } else {
                         sh ' echo  "llego" + params.ACCION'                 
                         sh 'cd jenkins-terraform/bastion && terraform apply -refresh=true -var-file="dev.tfvars"  -auto-approve'  
                }  // if

            }
            } //steps
        }  //stage
   }  // stages
} //pipeline
