# terraform
#Example Usage

provider "aws" {
 region = var.aws_region
}

module "my_instance_module" {
  #source = "../scalar"
  source = "github.com/ssanjoris/terraform"
  my_amz_linux_ami = "ami-0507f77897697c4ba"
  instance_type = "t2.micro"
  ec2_instance_name = "myvm01"
  ec2_access_key = "Linux-Oreon"
}
