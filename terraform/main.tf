provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0"  # Example Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = "your-ssh-key"

  tags = {
    Name = "web-server"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y python3
              sudo yum install -y git
              git clone https://github.com/your-user/your-repo.git /home/ec2-user/app
              cd /home/ec2-user/app
              pip3 install -r requirements.txt
              python3 app/app.py &
              EOF
}

output "instance_ip" {
  value = aws_instance.web_server.public_ip
}
