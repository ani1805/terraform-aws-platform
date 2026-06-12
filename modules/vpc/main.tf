resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = "${var.environment}-vpc"
    Environment = var.environment
  }
}
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.availability_zone_1
  tags = {
    Name        = "${var.environment}-public-subnet"
    Environment = var.environment
  }
}
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.availability_zone_1
  tags = {
    Name        = "${var.environment}-private-subnet-1"
    Environment = var.environment
  }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = var.availability_zone_2
  cidr_block        = var.private_subnet_2_cidr
  tags = {
    Name        = "${var.environment}-private-subnet-2"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name        = "${var.environment}-igw"
    Environment = var.environment
  }

}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name        = "${var.environment}-public_route_table"
    Environment = var.environment
  }

}

resource "aws_route_table_association" "public_route_table_assc" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name        = "${var.environment}-private_route_table"
    Environment = var.environment
  }

}

resource "aws_route_table_association" "private_route_table_assc" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.private.id
}