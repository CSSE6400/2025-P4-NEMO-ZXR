terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_files = ["./credentials"]
  default_tags {
    tags = {
      Environment = "Dev"
      Course      = "CSSE6400"
      StudentID   = "s4907253"
    }
  }
}

resource "aws_instance" "hextris-server" {
  ami           = "ami-08b5b3a93ed654d19"
  instance_type = "t2.micro"
  key_name      = "vockey"
  user_data = file("./serve-hextris.sh")

  tags = {
    Name = "hextris"
  }
}

output "hextris-url" {
  value = aws_instance.hextris-server.public_ip
}


