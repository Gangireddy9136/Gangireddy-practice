providers "aws" { 
  region = "us-east-1"
  
}
  


resource "aws_vpc" "Practice_vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "Practice_vpc"
  }
}

resource "aws_subnet" "Private_Subnet" {
  vpc_id     = aws_vpc.Practice_vpc.id
  cidr_block = "10.0.0.0/17"

  tags = {
    Name = "Private_Subnet"
  }
}

resource "aws_subnet" "Public_Subnet" {
  vpc_id     = aws_vpc.Practice_vpc.id
  cidr_block = "10.0.128.0/17"

  tags = {
    Name = "Public_Subnet"
  }
}

resource "aws_internet_gateway" "Practice_igw" {
  vpc_id = aws_vpc.Practice_vpc.id

  tags = {
    Name = "Practice_igw"
  }
}

resource "aws_route_table" "Practice_rtb" {
  vpc_id = aws_vpc.Practice_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Practice_igw.id
  
}

  tags = {
    Name = "Practice_rtb"
  }

  }

resource "aws_route_table_association" "rtb-asso" {
  subnet_id      = aws_subnet.Public_Subnet.id
  route_table_id = aws_route_table.Practice_rtb.id
}

resource "aws_instance" "Practice_ec2_Public" {
  ami           = "ami-0953476d60561c955"
  instance_type = "t3.micro"
  vpc_id     = aws_vpc.Practice_vpc.id
  subnet_id = aws_subnet.Public_Subnet.id

  tags = {
    Name = "Practice_ec2_Public"
  }
}

resource "aws_instance" "Practice_ec2_Private" {
  ami           = "ami-0953476d60561c955"
  instance_type = "t3.micro"
  vpc_id     = aws_vpc.Practice_vpc.id
  subnet_id = aws_subnet.Private_Subnet.id

  tags = {
    Name = "Practice_ec2_Private"
  }
}
