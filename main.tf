# Root main.tf
module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source         = "./modules/ec2"
  vpc_id         = module.vpc.vpc_id
  public_subnet  = module.vpc.public_subnet_id
  iam_role_name  = module.iam.iam_role_name
  key_name       = var.key_name
}

module "rds" {
  source         = "./modules/rds"
  vpc_id         = module.vpc.vpc_id
  private_subnet = module.vpc.private_subnet_id
  ec2_sg_id      = module.ec2.ec2_sg_id
}

module "s3" {
  source = "./modules/s3"
}

module "iam" {
  source = "./modules/iam"
}

module "cloudfront" {
  source           = "./modules/cloudfront"
  s3_bucket_domain = module.s3.bucket_name
}

module "route53" {
  source             = "./modules/route53"
  domain_name        = var.domain_name
  cloudfront_domain  = module.cloudfront.cdn_domain
  cloudfront_zone_id = var.cloudfront_zone_id
}
