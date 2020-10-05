resource "aws_instance" "vtt" {
  ami = "${var.ami_id}"
  instance_type = "t2.micro"
  key_name = aws_key_pair.vtt.name
  security_groups = ["${aws_security_group.vtt-ingress.id}"]

  tags {
    Name = "vtt"
  }

  subnet_id = "${aws_subnet.vtt.id}"
}

resource "aws_key_pair" "vtt" {
  key_name   = "vtt_key"
  public_key = var.public_key
}