output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
