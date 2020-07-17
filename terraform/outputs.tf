output "alb_dns_name" {
  value       = aws_lb.techALB.dns_name
  description = "Microservice endpoint for the ALB"
}