# ==================================================================
# eks.tf - le cluster Kubernetes (A ECRIRE a l'etape 5)
# Cible : le control plane EKS 1.36 + un node group de 3 t3.small.
# Reference : docs/architecture.md - README, etape 5.
#
# Ce fichier ne contient que ce guide : vous ecrirez les ressources
# a l'etape 5 (tant qu'il est vide, les etapes 3 et 4 restent
# jouables). Respectez les noms demandes ci-dessous.
# ==================================================================

# Define the EKS control plane.
resource "aws_eks_cluster" "main" {
  # Set the cluster name with the participant prefix.
  name = "${var.prenom}-eks"
  # Pin the Kubernetes version.
  version = "1.36"
  # Reference the control plane IAM role.
  role_arn = aws_iam_role.cluster.arn
  # Configure the cluster network.
  vpc_config {
    # Use both public subnets.
    subnet_ids = [
      # Reference the first public subnet.
      aws_subnet.public_a.id,
      # Reference the second public subnet.
      aws_subnet.public_b.id
    ]
  }
  # Wait for the control plane policy attachment.
  depends_on = [aws_iam_role_policy_attachment.cluster_eks]
}

# Define the EKS node group.
resource "aws_eks_node_group" "main" {
  # Reference the EKS cluster.
  cluster_name = aws_eks_cluster.main.name
  # Set the node group name with the participant prefix.
  node_group_name = "${var.prenom}-nodes"
  # Reference the node IAM role.
  node_role_arn = aws_iam_role.nodes.arn
  # Use both public subnets.
  subnet_ids = [
    # Reference the first public subnet.
    aws_subnet.public_a.id,
    # Reference the second public subnet.
    aws_subnet.public_b.id
  ]
  # Select the worker instance type.
  instance_types = ["t3.small"]
  # Configure the node group size.
  scaling_config {
    # Set the desired number of nodes.
    desired_size = 3
    # Set the minimum number of nodes.
    min_size = 3
    # Set the maximum number of nodes.
    max_size = 3
  }
  # Wait for all node policy attachments.
  depends_on = [
    # Wait for the worker node policy.
    aws_iam_role_policy_attachment.nodes_worker,
    # Wait for the ECR read-only policy.
    aws_iam_role_policy_attachment.nodes_ecr,
    # Wait for the EKS CNI policy.
    aws_iam_role_policy_attachment.nodes_cni
  ]
}
