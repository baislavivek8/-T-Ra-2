resource "aws_acm_certificate" "cert" {
  domain_name       = "${var.domain_name}"
  validation_method = "DNS"

  tags = {
    Environment = var.environment
      }

    lifecycle {
    create_before_destroy = true
  }
}


/*data "aws_route53_zone" "zone" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  name    = each.value.name
  type    = each.value.type
  zone_id = "${data.aws_route53_zone.zone.zone_id}"
  records = [each.value.record]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = "${aws_acm_certificate.cert.arn}"
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
  depends_on = [aws_acm_certificate.cert]
}

resource "aws_route53_record" "r53-record" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name = var.domain_name
  type = "A"

  alias {
    name = aws_alb.alb.dns_name
    zone_id = aws_alb.alb.zone_id
    evaluate_target_health = true
  }
} */
