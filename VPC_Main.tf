resource "aws_vpc" "new_vpc" {
  cidr_block = var.vpc_cidr[0]
  tags = {
      Name=var.vpc_name
  }
}

resource "aws_subnet" "new_pub_subnet" {
  vpc_id = aws_vpc.new_vpc.id
  count = length(var.pub_subnet_cidr)
  cidr_block = element(var.pub_subnet_cidr,count.index)
  availability_zone = element(var.azs,count.index )

  tags = {
    Name="${var.pub_subnet_name}  ${count.index}"
  }
}

resource "aws_subnet" "new_pvt_subnet" {
  vpc_id = aws_vpc.new_vpc.id
  count = length(var.pvt_subnet_cidr)
  cidr_block = element(var.pvt_subnet_cidr,count.index)
  availability_zone = element(var.azs,count.index )

  tags = {
    Name= "${var.pvt_subnet_name} ${count.index}"
  }
}

resource "aws_route_table" "new_pub_rt" {
  vpc_id         = aws_vpc.new_vpc.id
  tags = {
    Name= var.pub_route_table_name
  }
}

resource "aws_route_table" "new_pvt_rt" {
  vpc_id         = aws_vpc.new_vpc.id
  tags = {
    Name= var.pvt_route_table_name
  }
}

resource "aws_route_table_association" "new_pub_rt_ass" {
  count = length(aws_subnet.new_pub_subnet)
  route_table_id = aws_route_table.new_pub_rt.id
  subnet_id = element(aws_subnet.new_pub_subnet,count.index).id
}

resource "aws_route_table_association" "new_pvt_rt_ass" {
  count = length(aws_subnet.new_pvt_subnet)
  route_table_id = aws_route_table.new_pvt_rt.id
  subnet_id = element(aws_subnet.new_pvt_subnet,count.index ).id
}

resource "aws_internet_gateway" "new_igw" {
  tags = {
    Name=var.internet_gw_name
  }
}

resource "aws_internet_gateway_attachment" "rt_iqw_attachment" {
  internet_gateway_id = aws_internet_gateway.new_igw.id
  vpc_id              = aws_vpc.new_vpc.id
}

resource "aws_route" "new_pub_subnet_routes" {
  route_table_id = aws_route_table.new_pub_rt.id
  destination_cidr_block = var.route_to_internet
  gateway_id = aws_internet_gateway.new_igw.id
}

#resource "aws_route" "new_pvt_subnet_routes" {
#  route_table_id = aws_route_table.new_pvt_rt.id
#  destination_cidr_block = var.route_to_internet
#  gateway_id = aws_internet_gateway.new_igw.id
#}

resource "aws_network_interface" "aws_nw_instance" {
  count = length(aws_subnet.new_pub_subnet)
  subnet_id = element(aws_subnet.new_pub_subnet,count.index).id
  tags = {
    Name = "${var.nw_interface_name} ${count.index}"
  }
}


