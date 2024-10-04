resource "aws_vpc" "base" {
  cidr_block           = var.vpc_info.cidr_block
  tags                 = var.vpc_info.tags
  enable_dns_hostnames = var.vpc_info.enable_dns_hostnames

}

resource "aws_subnet" "public" {
  count             = length(var.public_subnets)
  cidr_block        = var.public_subnets[count.index].cidr_block
  vpc_id            = aws_vpc.base.id
  availability_zone = var.public_subnets[count.index].az
  tags              = var.public_subnets[count.index].tags
  depends_on        = [aws_vpc.base]

}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  cidr_block        = var.private_subnets[count.index].cidr_block
  vpc_id            = aws_vpc.base.id
  availability_zone = var.private_subnets[count.index].az
  tags              = var.private_subnets[count.index].tags
  depends_on        = [aws_vpc.base]

}

resource "aws_internet_gateway" "ntier" {
  count  = local.do_we_have_private_subnets ? 1 : 0
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "ntier-igw"
  }

}

resource "aws_route_table" "public" {
  count  = local.do_we_have_public_subnets ? 1 : 0
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "Public_RT"
  }

}
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[0].id
}

resource "aws_route" "internet" {
  count                  = local.do_we_have_public_subnets ? 1 : 0
  route_table_id         = aws_route_table.public[0].id
  gateway_id             = aws_internet_gateway.ntier[0].id
  destination_cidr_block = local.anywhere

}

resource "aws_route_table" "private" {
  count  = local.do_we_have_private_subnets ? 1 : 0
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "Private_RT"
  }

}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[0].id
}