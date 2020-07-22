output "alb_dns_name" {
  value       = aws_lb.techALB.dns_name
  description = "Microservice endpoint for the ALB"
}

output "ecs_task_arn" {
	value = aws_ecs_task_definition.registry.arn
	description = "ARN ECS Task definition"
}