resource "aws_ecs_cluster" "default" {
  name = "tech-insiders"
}


resource "aws_ecr_repository" "microservice" {
  name = "tech-insiders-microservice"

}



data "template_file" "microservice" {
  template = "${file("templates/backend-microservice.tpl")}"

  vars = {
    app_image = "${aws_ecr_repository.microservice.repository_url}:latest"
  }

}

resource "aws_ecs_task_definition" "registry" {
  family                   = "microservice"
  container_definitions    = "${data.template_file.microservice.rendered}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = "${aws_iam_role.backend_role.arn}"
}

resource "aws_ecs_service" "backend-service" {
  name            = "backend-service"
  cluster         = "${aws_ecs_cluster.default.id}"
  task_definition = "${aws_ecs_task_definition.registry.arn}"
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = ["${aws_subnet.private-subnet-us-east-1.id}", "${aws_subnet.private2-subnet-us-east-1.id}"]
    security_groups = ["${aws_security_group.ecs.id}"]


  }

  load_balancer {
    target_group_arn = "${aws_lb_target_group.tgtech.id}"
    container_name   = "microservice"
    container_port   = "80"




  }



}


