locals {
  ecr_repository_name       = var.ecr_repository_name
  service_name              = var.service_name
  service_port              = 3000
  service_release_tag       = "latest"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_apprunner_service" "runner_service" {
    service_name                = local.service_name
    source_configuration {
      authentication_configuration {
        access_role_arn         = aws_iam_role.runner_role.arn
      }
      image_repository {
        image_identifier        = "${aws_ecr_repository.ecr_repository.repository_url}:${local.service_release_tag}"
        image_repository_type   = "ECR" 
        image_configuration {
          port                  = local.service_port
        }
      }
    } 
}

output "service_url" {
    value = aws_apprunner_service.runner_service.service_url
  
}