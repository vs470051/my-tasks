
data "aws_availability_zones" "Availability_Zones" {
  state = "available"
}

resource "aws_vpc" "wordpress_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "Wordpress_vpc"
  }
}

resource "aws_subnet" "subnets" {
  count                   = var.Subnet_Count
  vpc_id                  = aws_vpc.wordpress_vpc.id
  cidr_block              = var.Subnet_CIDR_block[count.index]
  availability_zone       = data.aws_availability_zones.Availability_Zones.names[count.index]
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.Subnet_name[count.index]}"
  }
}

resource "aws_internet_gateway" "Internet_gateway" {
  vpc_id = aws_vpc.wordpress_vpc.id

  tags = {
    Name = "Word_press"
  }
}

resource "aws_route_table" "VPC_route_table" {
  vpc_id = aws_vpc.wordpress_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Internet_gateway.id
  }
}

resource "aws_route_table_association" "route_table_association" {
  count = var.Subnet_Count
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.VPC_route_table.id
}

