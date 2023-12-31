resource "aws_security_group" "my_tf_sg" {
  name = var.security_grp_name

  ingress {
    description = "SSH Ingress"
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP Ingress"
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

}

data "aws_key_pair" "aws_ex_keypair" {
  key_name           = var.ec2_access_key
  include_public_key = true
}

resource "aws_instance" "new_ec2_instance" {
  count = length(var.azs)
  ami = var.my_amz_linux_ami
  instance_type = var.instance_type

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.aws_nw_instance[count.index].id
  }


  #cpu_options {
  #  core_count       = 2
  #  threads_per_core = 2
  #}

  tags = {
    Name = var.ec2_instance_name
  }
}

resource "aws_ebs_volume" "new_aws_ebs" {
  availability_zone = aws_instance.new_ec2_instance[0].availability_zone
  size              = 2
  encrypted         = false

  tags = {
    name = "my_ebs"
  }
}

resource "aws_volume_attachment" "new_ebs_mount1" {
  #availability_zone = aws_instance.new_ec2_instance[0].availability_zone
  device_name       = "/dev/sdb"
  instance_id       = aws_instance.new_ec2_instance[0].id
  volume_id         = aws_ebs_volume.new_aws_ebs.id
}
