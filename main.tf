provider "aws" { 
    
}

variable "subnet_cidr_block" {
  description = "subnet cidr block"
  default = "10.0.10.0/24 "
}

variable "vpc_cidr_block" {
  description = "vpc cidr block"
}

resource "aws_vpc" "development-vpc" {
  cidr_block  =var.vpc_cidr_block
  tags ={ 
    Name: "Development"
  }
}


resource "aws_subnet" "dev-subnet-1" {
    vpc_id=aws_vpc.development-vpc.id
    cidr_block = "10.0.10.0/24"
  tags ={
    Name: "subnet-1-Dev"
  }
   
} 

data "aws_vpc" "existing_vpc" {
  default = true
}

resource "aws_subnet" "dev-subnet-2" {
    vpc_id = data.aws_vpc.existing_vpc.id
    cidr_block = var.subnet_cidr_block  
    tags ={
    Name: "subnet-1-Default"
  }
} 

 output "dev-vpc-id" {
  value = aws_vpc.development-vpc.id
 }

 output "dev-subnet-id" {
  value = aws_subnet.dev-subnet-1.id
 }