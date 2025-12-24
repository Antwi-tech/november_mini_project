pipeline {
    agent any

    environment {
        TF_DIR = "terraform"
        ANSIBLE_DIR = "ansible"
    }

    stages {

        stage("Checkout code") {
            steps {
                git branch: 'main',
                    url: 'https://github.com/women-techsters-fellowship/november_mini_project.git'
            }
        }

        stage("Build & Push Docker Image") {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'docker_creds',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {
                    sh '''
                        docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
                        docker build -t $DOCKER_USERNAME/django-app:v1 .
                        docker push $DOCKER_USERNAME/django-app:v1
                    '''
                }
            }
        }

        stage("Terraform Apply") {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws_creds']
                ]) {
                    sh '''
                        cd terraform
                        terraform init
                        terraform apply --auto-approve
                    '''
                }
            }
        }

        stage("Get EC2 Public IP") {
            steps {
                script {
                    env.EC2_HOST = sh(
                        script: "cd terraform && terraform output -raw ec2_public_ip",
                        returnStdout: true
                    ).trim()
                }
                echo "EC2 Public IP: ${EC2_HOST}"
            }
        }

        stage("Deploy with Ansible") {
            steps {
                withCredentials([
                    sshUserPrivateKey(
                        credentialsId: 'EC2_KEY',
                        keyFileVariable: 'SSH_KEY'
                    ),
                    usernamePassword(
                        credentialsId: 'docker_creds',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {
                    sh '''
                        chmod 600 "$SSH_KEY"

                        cat > ansible/inventory.ini <<EOF
[ec2]
${EC2_HOST} ansible_user=ubuntu ansible_ssh_private_key_file=${SSH_KEY}
EOF

                        ansible-playbook \
                          -i ansible/inventory.ini \
                          ansible/playbook.yml \
                          --extra-vars "docker_username=$DOCKER_USERNAME docker_password=$DOCKER_PASSWORD"
                    '''
                }
            }
        }
    }
}
