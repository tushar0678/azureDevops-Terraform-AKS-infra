# EKS
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.eks_cluster_name
  cluster_version = "1.29"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
  enable_irsa     = true

  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_types   = [var.eks_node_group_instance_type]
      subnet_ids       = module.vpc.private_subnets
    }
  }

  tags = {
    Environment = "dev"
    Name        = "eks-cluster"
  }
}
