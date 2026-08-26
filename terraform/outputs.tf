# ==================================================================
# outputs.tf - ce que Terraform affiche apres l'apply (etape 5)
# Un output = une valeur calculee, affichee en fin d'apply et
# relisible a tout moment avec : terraform output
# ==================================================================

# Expose the EKS cluster name.
output "cluster_name" {
  # Read the name from the EKS cluster resource.
  value = aws_eks_cluster.main.name
}

# Expose the command used to update the local kubeconfig.
output "update_kubeconfig_command" {
  # Build the command with the cluster name and AWS region.
  value = "aws eks update-kubeconfig --name ${aws_eks_cluster.main.name} --region ${var.region}"
}
