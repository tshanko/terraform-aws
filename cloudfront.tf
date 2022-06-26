module "cloudfront" {
  source    = "terraform-aws-modules/cloudfront/aws"
 
  aliases   = ["cdn.example.com"]

  version   = "2.9.3"
  comment   = "Create Cloudfront"
  enabled   = true
  is_ipv6_enabled = true
  price_class = "PriceClass_All"
  wait_for_deployment = false
  retain_on_delete    = false



create_origin_access_identity = true
origin_access_identities = {
  static-website-deploy = "Amazon s3 bucket"
}


origin = {
  bucket_s3 = {
    domain_name = "static_website_deploy_domain_name"
     s3_origin_config = {
	origin_access_identity = "static-website-deploy"
        origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
   }
  }
 }
default_cache_behavior =  {
   target_origin_id 	= "bucket_s3"
   viewer_protocol_policy = "redirect-to-https"

   default_ttl = 5400
   min_ttl     = 1800
   max_ttl     = 1800

   allowed_methods  = ["GET","HEAD"]
   cached_methods   = ["GET","HEAD"]
}

default_root_object = "index.html"
}
