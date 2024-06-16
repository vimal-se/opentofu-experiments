provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "tf-vpc" {
  cidr_block = "172.16.0.0/16"
  tags = {
    Name = "tf-example"
  }
}

resource "aws_internet_gateway" "tf-internet-gateway" {
  vpc_id = aws_vpc.tf-vpc.id
}

resource "aws_route_table" "tf-second_rt" {
  vpc_id = aws_vpc.tf-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-internet-gateway.id
  }

  tags = {
    Name = "2nd Route Table"
  }
}

resource "aws_subnet" "tf-subnet-example1" {
  vpc_id            = aws_vpc.tf-vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "tf-subnet"
  }
}

resource "aws_route_table_association" "tf-public_subnet_asso" {
  subnet_id      = aws_subnet.tf-subnet-example1.id
  route_table_id = aws_route_table.tf-second_rt.id
}

resource "aws_security_group" "tf-security-group" {
  name        = "my-security-group"
  description = "Allow inbound SSH and HTTP traffic"
  vpc_id = aws_vpc.tf-vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0e1d06225679bc1c5"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.tf-subnet-example1.id
  security_groups = [aws_security_group.tf-security-group.id]
  associate_public_ip_address = true
  key_name = "ibs-dev"
  depends_on = [aws_internet_gateway.tf-internet-gateway]

  user_data = file("script.sh")

  tags = {
    Name = "HelloWorld"
  }
}

output "web_instance_ip" {
  value = aws_instance.web.public_ip
}

