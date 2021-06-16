resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {

}

resource "aws_cloudfront_distribution" "asset_s3_distribution" {


    depends_on = [aws_s3_bucket.asset_bucket]
    enabled             = true
    is_ipv6_enabled     = true

    comment             = "${var.client_name}-${var.environment}-assets-cdn"

    origin {
        domain_name = aws_s3_bucket.asset_bucket.bucket_regional_domain_name
        origin_id   = aws_s3_bucket.asset_bucket.id

            s3_origin_config {
        origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"

      }
    }

  default_cache_behavior {

    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]

    target_origin_id = aws_s3_bucket.asset_bucket.id

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0

  }

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }


    tags = {
        Environment = "${var.client_name}-${var.environment}"
    }
  viewer_certificate {
    cloudfront_default_certificate = true
  }

  logging_config {
      include_cookies = false
      bucket          = aws_s3_bucket.log_bucket.bucket_domain_name
      prefix          = "cdn"
  }


}