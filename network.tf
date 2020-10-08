resource "aws_vpc" "vtt" {
  cidr_block = "10.0.0.0/24"
  enable_dns_hostnames = true
  enable_dns_support = true
}

resource "aws_subnet" "vtt" {
  cidr_block = "${cidrsubnet(aws_vpc.vtt.cidr_block, 3, 1)}"
  vpc_id = "${aws_vpc.vtt.id}"
  availability_zone = "us-west-2a"
}

resource "aws_security_group" "vtt" {
  name = "vtt-allow-all"
  vpc_id = "${aws_vpc.vtt.id}"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "ingress_22" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.vtt.id
}

resource "aws_security_group_rule" "ingress_80" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.vtt.id
}

resource "aws_security_group_rule" "ingress_443" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.vtt.id
}

resource "aws_security_group_rule" "ingress_30000" {
  type        = "ingress"
  from_port   = 30000
  to_port     = 30000
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.vtt.id
}

resource "aws_eip" "vtt" {
  instance = "${aws_instance.vtt.id}"
  vpc      = true
}

resource "aws_internet_gateway" "vtt" {
  vpc_id = "${aws_vpc.vtt.id}"
}

resource "aws_route_table" "vtt" {
  vpc_id = "${aws_vpc.vtt.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vtt.id}"
  }

  tags = {
    Name = "vtt"
  }
}

resource "aws_route_table_association" "vtt" {
  subnet_id      = "${aws_subnet.vtt.id}"
  route_table_id = "${aws_route_table.vtt.id}"
}