# ==================================================================
# network.tf - le reseau du PoC (A COMPLETER a l'etape 3 du TD)
# Cible : 1 VPC + 2 subnets publics (un par zone) + 1 Internet
# Gateway + 1 table de routage associee aux 2 subnets.
# Reference : docs/architecture.md - suivez le README, etape 3.
# Les blocs sont poses avec leurs noms : gardez ces noms, les autres
# fichiers (eks.tf) les referencent.
# ==================================================================

resource "aws_vpc" "main" {
  # Set the VPC address range.
          cidr_block = "10.0.0.0/16"
  # Enable DNS support.
  enable_dns_support = true
  # Enable DNS hostnames.
  enable_dns_hostnames = true
  # Set the VPC name.
  tags = {
    # Build the name with the participant prefix.
    Name = "${var.prenom}-vpc"
  }
}

resource "aws_subnet" "public_a" {
  # Attach the subnet to the VPC.
  vpc_id = aws_vpc.main.id
  # Set the subnet address range.
  cidr_block = "10.0.1.0/24"
  # Build the availability zone from the region.
  availability_zone = "${var.region}a"
  # Assign public IP addresses automatically.
  map_public_ip_on_launch = true
  # Set the subnet name.
  tags = {
    # Build the name with the participant prefix.
    Name = "${var.prenom}-public-a"
  }
}

resource "aws_subnet" "public_b" {
  # Attach the subnet to the VPC.
  vpc_id = aws_vpc.main.id
  # Set the subnet address range.
  cidr_block = "10.0.2.0/24"
  # Build the availability zone from the region.
  availability_zone = "${var.region}b"
  # Assign public IP addresses automatically.
  map_public_ip_on_launch = true
  # Set the subnet name.
  tags = {
    # Build the name with the participant prefix.
    Name = "${var.prenom}-public-b"
  }
}

resource "aws_internet_gateway" "main" {
  # Attach the gateway to the VPC.
  vpc_id = aws_vpc.main.id
  # Set the gateway name.
  tags = {
    # Build the name with the participant prefix.
    Name = "${var.prenom}-igw"
  }
}

resource "aws_route_table" "public" {
  # Attach the route table to the VPC.
  vpc_id = aws_vpc.main.id
  # Declare the default route.
  route {
    # Send all IPv4 traffic to the Internet Gateway.
    cidr_block = "0.0.0.0/0"
    # Use the declared Internet Gateway.
    gateway_id = aws_internet_gateway.main.id
  }
  # Set the route table name.
  tags = {
    # Build the name with the participant prefix.
    Name = "${var.prenom}-public-rt"
  }
}

# Associate the route table with the first subnet.
resource "aws_route_table_association" "public_a" {
  # Reference the first public subnet.
  subnet_id = aws_subnet.public_a.id
  # Reference the public route table.
  route_table_id = aws_route_table.public.id
}

# Associate the route table with the second subnet.
resource "aws_route_table_association" "public_b" {
  # Reference the second public subnet.
  subnet_id = aws_subnet.public_b.id
  # Reference the public route table.
  route_table_id = aws_route_table.public.id
}
