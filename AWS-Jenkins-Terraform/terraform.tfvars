region                      = "us-east-1"
vpc_cidr                    = "10.0.0.0/16"
public_subnet_cidrs        = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs       = ["10.0.3.0/24", "10.0.4.0/24"]
key_name                   = "your-ec2-keypair"
eks_cluster_name           = "private-eks-cluster"
eks_node_group_instance_type = "t3.medium"

domain_name  = "example.com"
alb_dns_name = "my-alb-123456789.elb.amazonaws.com"
alb_zone_id  = "Z35SXDOTRQ7X7K"
alb_arn      = "arn:aws:elasticloadbalancing:us-east-1:123456789012:loadbalancer/app/my-alb/1234567890abcdef"
