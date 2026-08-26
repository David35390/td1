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

# TODO(4.1) : le role du control plane EKS
#   resource "aws_iam_role" "cluster"
#   - name = "<prenom>-eks-cluster-role" (via var.prenom)
#   - assume_role_policy : seul le service eks.amazonaws.com peut
#     endosser ce role (jsonencode d'un document de confiance)

# TODO(4.2) : l'attachement de la policy du control plane
#   resource "aws_iam_role_policy_attachment" "cluster_eks"
#   - policy_arn : arn:aws:iam::aws:policy/AmazonEKSClusterPolicy

# TODO(4.3) : le role des noeuds
#   resource "aws_iam_role" "nodes"
#   - name = "<prenom>-eks-node-role"
#   - assume_role_policy : ici c'est ec2.amazonaws.com qui endosse
#     (les noeuds sont des instances EC2)

# TODO(4.4) : les TROIS attachements de policies des noeuds
#   resource "aws_iam_role_policy_attachment" : nodes_worker,
#   nodes_ecr, nodes_cni - avec, dans l'ordre :
#   - arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy
#   - arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly
#   - arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy
