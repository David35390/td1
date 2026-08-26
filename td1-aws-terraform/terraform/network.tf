# ==================================================================
# network.tf - le reseau du PoC (A COMPLETER a l'etape 3 du TD)
# Cible : 1 VPC + 2 subnets publics (un par zone) + 1 Internet
# Gateway + 1 table de routage associee aux 2 subnets.
# Reference : docs/architecture.md - suivez le README, etape 3.
# Les blocs sont poses avec leurs noms : gardez ces noms, les autres
# fichiers (eks.tf) les referencent.
# ==================================================================

resource "aws_vpc" "main" {
  # TODO(3.1) : le VPC
  #   - cidr_block "10.0.0.0/16"
  #   - enable_dns_support et enable_dns_hostnames a true (exige par EKS)
  #   - tag Name = "<prenom>-vpc" (construisez-le avec var.prenom)
}

resource "aws_subnet" "public_a" {
  # TODO(3.2) : premier subnet public, zone eu-west-3a
  #   - rattache au VPC (vpc_id = aws_vpc.main.id)
  #   - cidr_block "10.0.1.0/24", availability_zone construite avec var.region
  #   - IP publique automatique au lancement (pas de NAT dans ce PoC)
  #   - tag Name
}

resource "aws_subnet" "public_b" {
  # TODO(3.2 suite) : second subnet public, zone eu-west-3b,
  #   cidr_block "10.0.2.0/24" - meme structure que public_a
}

resource "aws_internet_gateway" "main" {
  # TODO(3.3) : la porte du VPC vers Internet
  #   - un seul argument suffit : le VPC de rattachement
  #   - tag Name
}

resource "aws_route_table" "public" {
  # TODO(3.4) : la table de routage publique
  #   - rattachee au VPC
  #   - un bloc route : cidr_block "0.0.0.0/0" -> gateway_id de l'IGW
  #   - tag Name
}

# TODO(3.5) : associez la table de routage aux DEUX subnets
# (2 ressources aws_route_table_association : public_a et public_b).
