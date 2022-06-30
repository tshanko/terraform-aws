module "cloudfront" {
  source    = "terraform-aws-modules/cloudfront/aws"
 
  aliases   = ["www.${var.domain_name}"]

  version   = "2.9.3"
  comment   = "Create Cloudfront"
  enabled   = true
  is_ipv6_enabled = true
  price_class = "PriceClass_All"
  wait_for_deployment = false
  retain_on_delete    = false



origin_access_identities = {
  bucket_s3 = "Cloudfront Access"
}


origin = {
  custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
 }

  s3_bucket = {
     s3_origin_config = {
	origin_access_identity = "bucket_s3"
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
viewer_certificate = {
  "cloudfront_default_certificate": true,
  "minimum_protocol_version": "TLSv1"
  }


default_root_object = "index.html"

}
