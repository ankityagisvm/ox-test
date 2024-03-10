provider "aws" {
  region = var.aws_region
}


resource "aws_instance" "ox_test_ins" {
  ami             = var.instance_ami
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [var.security_group]
  subnet_id       = var.instance_subnet
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

              # Install helm
              wget https://get.helm.sh/helm-v3.14.2-linux-amd64.tar.gz
              tar xvf helm-v3.14.2-linux-amd64.tar.gz
              sudo mv linux-amd64/helm /usr/local/bin
              rm -rf helm-v3.14.2-linux-amd64.tar.gz
              rm -rf linux-amd64

              # install virtualhost requiremets
              sudo apt install ca-certificates curl gnupg wget apt-transport-https -y
              sudo install -m 0755 -d /etc/apt/keyrings
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
              sudo chmod a+r /etc/apt/keyrings/docker.gpg
              echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

              # Install Docker
              curl -fsSL https://get.docker.com | sudo sh
              sudo usermod -aG docker ubuntu

              ## Download and Install Minikube Binary
              curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
              sudo install minikube-linux-amd64 /usr/local/bin/minikube
              # Install kubectl
              sudo curl -LO "https://dl.k8s.io/release/v1.29.2/bin/linux/amd64/kubectl"
              sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

              # Verify installation
              docker --version
              kubectl version --client
              EOF

  tags = {
    Name = "test-instance"
  }
}
