resource "aws_vpc" "dino-vpc" {
  cidr_block = var.cidr_block
}

# ---------------- subnets ----------------

### note: the cidrsubnet function generate the cidr_block for the subnet based on the cidr_block of the vpc
# ex: vpc-cidr_block = 10.0.0.0/16 then the siders are 10.0.0.0/24, 10.0.1.0/24, ......etc
# so: 24 = 16 + 8,  count.index define a unique id for each subnit (0,1,..etc)  

resource "aws_subnet" "subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.dino-vpc.id
  cidr_block              = cidrsubnet(aws_vpc.dino-vpc.cidr_block, 8, count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
#   map_public_ip_on_launch = true
}


# note: data.aws_availability_zones.available.names is a list of all availability zones in the region 
# helps in distributing resources across multiple availability zones for high availability
data "aws_availability_zones" "available" {}
