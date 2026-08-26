# ==================================================================
# iam.tf - les deux identites du cluster (A ECRIRE a l'etape 4)
# Cible : 2 roles IAM + leurs attachements de policies managees.
# Reference : docs/architecture.md, ligne IAM - README, etape 4.
#
# Ce fichier ne contient que ce guide : vous ecrirez les ressources
# a l'etape 4 (tant qu'il est vide, terraform plan l'ignore et
# l'etape 3 reste jouable). Respectez les NOMS demandes ci-dessous :
# eks.tf les referencera.
# ==================================================================

# Define the EKS control plane role.
resource "aws_iam_role" "cluster" {
  # Set the role name with the participant prefix.
  name = "${var.prenom}-eks-cluster-role"
  # Define the trust policy for the EKS service only.
  assume_role_policy = jsonencode({
    # Define the policy language version.
    Version = "2012-10-17"
    # Define the trust policy statement.
    Statement = [{
      # Allow the trusted service to assume the role.
      Effect = "Allow"
      # Set the trusted principal to the EKS service.
      Principal = {
        # Identify the trusted AWS service.
        Service = "eks.amazonaws.com"
      }
      # Allow role assumption.
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach the EKS control plane policy.
resource "aws_iam_role_policy_attachment" "cluster_eks" {
  # Reference the EKS control plane role.
  role = aws_iam_role.cluster.name
  # Set the exact AWS managed policy ARN.
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# Define the EKS node role.
resource "aws_iam_role" "nodes" {
  # Set the role name with the participant prefix.
  name = "${var.prenom}-eks-node-role"
  # Define the trust policy for the EC2 service only.
  assume_role_policy = jsonencode({
    # Define the policy language version.
    Version = "2012-10-17"
    # Define the trust policy statement.
    Statement = [{
      # Allow the trusted service to assume the role.
      Effect = "Allow"
      # Set the trusted principal to the EC2 service.
      Principal = {
        # Identify the trusted AWS service.
        Service = "ec2.amazonaws.com"
      }
      # Allow role assumption.
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach the EKS worker node policy.
resource "aws_iam_role_policy_attachment" "nodes_worker" {
  # Reference the EKS node role.
  role = aws_iam_role.nodes.name
  # Set the exact AWS managed policy ARN.
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Attach the read-only ECR policy.
resource "aws_iam_role_policy_attachment" "nodes_ecr" {
  # Reference the EKS node role.
  role = aws_iam_role.nodes.name
  # Set the exact AWS managed policy ARN.
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# Attach the EKS CNI policy.
resource "aws_iam_role_policy_attachment" "nodes_cni" {
  # Reference the EKS node role.
  role = aws_iam_role.nodes.name
  # Set the exact AWS managed policy ARN.
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
