# ==================================================================
# eks.tf - le cluster Kubernetes (A ECRIRE a l'etape 5)
# Cible : le control plane EKS 1.36 + un node group de 3 t3.small.
# Reference : docs/architecture.md - README, etape 5.
#
# Ce fichier ne contient que ce guide : vous ecrirez les ressources
# a l'etape 5 (tant qu'il est vide, les etapes 3 et 4 restent
# jouables). Respectez les noms demandes ci-dessous.
# ==================================================================

# TODO(5.1) : le control plane
#   resource "aws_eks_cluster" "main"
#   - name = "<prenom>-eks", version Kubernetes "1.36" (epinglee)
#   - role_arn : l'ARN du role "cluster" cree dans iam.tf
#   - bloc vpc_config : subnet_ids = les DEUX subnets de network.tf
#   - depends_on : l'attachement de policy du role cluster
#     (le role doit porter ses droits AVANT la creation du cluster)

# TODO(5.2) : le node group
#   resource "aws_eks_node_group" "main"
#   - cluster_name : celui du cluster ci-dessus
#   - node_group_name = "<prenom>-nodes"
#   - node_role_arn : l'ARN du role "nodes" de iam.tf
#   - subnet_ids : les deux subnets publics
#   - instance_types = ["t3.small"]
#   - bloc scaling_config : desired_size = min_size = max_size = 3
#   - depends_on : les TROIS attachements de policies des noeuds
