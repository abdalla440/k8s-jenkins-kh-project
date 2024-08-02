resource "aws_vpc" "dino-vpc" {
  cidr_block = var.cidr_block
  # enable_dns_support = true
  # enable_dns_hostnames = true
 tags = {
    Name = "dino-vpc"
  }
}

# ---------------- subnets ----------------

### note: the cidrsubnet function generates the cidr_block for the subnet based on the cidr_block of the vpc
# ex: vpc-cidr_block = 10.0.0.0/16 then the cidr blocks are 10.0.0.0/24, 10.0.1.0/24, ......etc
# so: 24 = 16 + 8, count.index defines a unique id for each subnet (0,1,..etc)

resource "aws_subnet" "subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.dino-vpc.id
  cidr_block              = cidrsubnet(aws_vpc.dino-vpc.cidr_block, 8, count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "dino-subnet-${count.index}"
  }
}


# note: data.aws_availability_zones.available.names is a list of all availability zones in the region 
# helps in distributing resources across multiple availability zones for high availability
data "aws_availability_zones" "available" {}

resource "aws_internet_gateway" "dino-gw" {
  vpc_id = aws_vpc.dino-vpc.id
  tags = {
    Name = "dino-gw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.dino-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dino-gw.id
  }
 tags = {
    Name = "dino-public-route-table"
  }
}

resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = element(aws_subnet.subnet.*.id, count.index)
  route_table_id = aws_route_table.public.id
}
