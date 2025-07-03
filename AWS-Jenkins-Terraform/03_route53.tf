
# Route 53 Hosted Zone
resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "eks_api" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "api"
  type    = "A"
  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

# AWS WAFv2 to block China
resource "aws_wafv2_web_acl" "block_china" {
  name        = "waf-block-cn"
  scope       = "REGIONAL"
  description = "Block all traffic from China"

  default_action {
    allow {}
  }

  rule {
    name     = "block-cn"
    priority = 1
    action {
      block {}
    }
    statement {
      geo_match_statement {
        country_codes = ["CN"]
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "block-cn"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "web-acl"
    sampled_requests_enabled   = true
  }
}

# Associate WAF with ALB
resource "aws_wafv2_web_acl_association" "alb_waf" {
  resource_arn = var.alb_arn
  web_acl_arn  = aws_wafv2_web_acl.block_china.arn
}
