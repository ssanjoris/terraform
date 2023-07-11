variable "vpc_cidr" {
  default = ["10.0.0.0/16"]
}

variable "vpc_name" {
  default = "example_vpc"
}

variable "pub_subnet_cidr" {
  default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "pub_subnet_name" {
  default = "new_pub_subnet"
}

variable "pvt_subnet_cidr" {
  default = ["10.0.3.0/24","10.0.4.0/24"]
}

variable "pvt_subnet_name" {
  default = "new_pvt_subnet"
}

variable "azs" {
  default = ["us-west-2a","us-west-2b"]
}

variable "route_to_internet" {
  default = "0.0.0.0/0"
}

variable "internet_gw_name" {
  default = "example_inet_gway"
}

variable "my_amz_linux_ami" {
  default = "ami-0507f77897697c4ba"
}

variable "pvt_route_table_name" {
  default = "example_pvt_route_table"
}
variable "pub_route_table_name" {
  default = "example_pub_route_table"
}

variable "security_grp_name" {
  default = "example_sg_name"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ec2_instance_name" {
  default = "example_ec2_name"
}

variable "nw_interface_name" {
  default = "new_primary_network_interface"
}

variable "ec2_access_key" {
  default = "Linux-Oreon"
}