# ==================================================================
# outputs.tf - ce que Terraform affiche apres l'apply (etape 5)
# Un output = une valeur calculee, affichee en fin d'apply et
# relisible a tout moment avec : terraform output
# ==================================================================

# TODO(5.3) : un output "cluster_name" qui expose le nom du cluster
# (value = le name de la ressource aws_eks_cluster.main).

# TODO(5.4) : un output "update_kubeconfig_command" qui construit la
# commande complete "aws eks update-kubeconfig --name <nom-du-cluster>
# --region <region>" - vous la copierez-collerez a l'etape 6.
