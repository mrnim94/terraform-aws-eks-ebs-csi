# terraform-aws-eks-ebs-csi

## Usage

```hcl
# Terraform Remote State Datasource - Remote Backend AWS S3
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "terraform-on-aws-eks-nim"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = var.aws_region
  }
}

module "eks-ebs-csi" {
  source  = "mrnim94/eks-ebs-csi/aws"
  version = "1.0.11"

  aws_region = "us-east-1"
  environment = "dev"
  business_divsion = "SAP"

 eks_cluster_certificate_authority_data = data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data
 eks_cluster_endpoint = data.terraform_remote_state.eks.outputs.cluster_endpoint
 eks_cluster_id = data.terraform_remote_state.eks.outputs.cluster_id
 aws_iam_openid_connect_provider_arn = data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_arn
}
```

If you use EKS module.

```hcl
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "terraform-on-aws-eks-nim"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = var.aws_region
  }
}

module "eks-ebs-csi" {
  source  = "mrnim94/eks-ebs-csi/aws"
  version = "1.0.11"

  aws_region = var.aws_region
  environment = var.environment
  business_divsion = var.business_divsion

 eks_cluster_certificate_authority_data = data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data
 eks_cluster_endpoint = data.terraform_remote_state.eks.outputs.cluster_endpoint
 eks_cluster_id = data.terraform_remote_state.eks.outputs.cluster_id
 aws_iam_openid_connect_provider_arn = data.terraform_remote_state.eks.outputs.oidc_provider_arn
}
```


If you use Self-Manage Node Group EKS (windows node)

```hcl
data "aws_eks_cluster" "dev-mdcl-nimtechnology-engines" {
  name = var.cluster_id
}


module "eks-ebs-csi" {
  source  = "mrnim94/eks-ebs-csi/aws"
  version = "1.0.11"

  aws_region = var.aws_region
  environment = var.environment
  business_divsion = var.business_divsion

 eks_cluster_certificate_authority_data = data.aws_eks_cluster.dev-mdcl-nimtechnology-engines.certificate_authority[0].data
 eks_cluster_endpoint = data.aws_eks_cluster.dev-mdcl-nimtechnology-engines.endpoint
 eks_cluster_id = var.cluster_id
 aws_iam_openid_connect_provider_arn = "arn:aws:iam::${element(split(":", "${data.aws_eks_cluster.dev-mdcl-nimtechnology-engines.arn}"), 4)}:oidc-provider/${element(split("//", "${data.aws_eks_cluster.dev-mdcl-nimtechnology-engines.identity[0].oidc[0].issuer}"), 1)}"
}
```


Datas are gotten form terraform state.

```hcl
Changes to Outputs:
  + cluster_certificate_authority_data = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUMvakNDQWVhZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJeU1UQXhPREEzTVRZd05sb1hEVE15TVRBeE5UQTNNVFl3Tmxvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTTRZCjhJbmRDLzFUNi8xb2F3Y3ZsUkUwMnMwaEM0V1B4bW5iN3BDb1J4S0R4ZXpnVW43UTNGdUZQMDNEaEZJRWpHMDQKQ0tqVzl4aEhWMExkK0RoWlBiVGwyUUpKVQVWtCSVhpQXdBK0NFYzNtRGh0OUd3bDMzTUt6aDgzY2RMQmJLd2sKRGR6MllRU29zQS8ydzB2OXdXZ2ZMUEdRU3N5NStzaXlyN05wRE5NdW1GelJ6bWhXOFg0d3FqTitCOW5zUkw1UApvWVVKYUlBam81a2ZWN1VFcHlQTkllMjNPZHZjUWZoYllYeHVuMlFsd2NDWTVIT2tvQzRnZUJ6VjhOQVVHOVM4Cm9QL2hkODhTOGZHVU5PaEFtVXJDK3lPS3plTXExRnNnYkpFODcvMXdWN0NzYXNENTFvTS8vYW5FeXhZV0I4UUQKT3FVPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg=="
  + cluster_endpoint                   = "https://086FB70912E24810NIM548C.yl4.us-west-2.eks.amazonaws.com"
  + cluster_id                         = "devops-nimtechnology"
  + oidc_provider_arn                  = "arn:aws:iam::223200000194:oidc-provider/oidc.eks.us-west-2.amazonaws.com/id/086FB70912E248103C0INIM6A548C"
  ```