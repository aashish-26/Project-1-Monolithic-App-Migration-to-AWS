variable "key_name" {
  description = "Name of the existing EC2 Key Pair to use for SSH"
  type        = string
}

variable "domain_name" {
  description = "Your custom domain name to link with Route 53"
  type        = string
}

variable "cloudfront_zone_id" {
  description = "CloudFront Hosted Zone ID (default value works for all accounts)"
  type        = string
  default     = "Z2FDTNDATAQYW2"
}