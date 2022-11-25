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