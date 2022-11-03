resource "aws_iam_role" "runner_role" {
    name                = "${local.service_name}-aws-role"
    assume_role_policy  = jsonencode({
        Version         = "2012-10-17"
        Statement       = [
            {
                Action  = "sts:AssumeRole"
                Effect  = "Allow"
                Sid     = ""
                Principal = {
                    Service   = "build.apprunner.amazonaws.com"
                }
            }
        ]
    }) 
}

resource "aws_iam_role_policy_attachment" "runner_role_policy_attachment" {
    role                = aws_iam_role.runner_role.name
    policy_arn          = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
}