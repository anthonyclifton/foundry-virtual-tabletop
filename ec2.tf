resource "aws_instance" "vtt" {
  ami = var.ami_id
  instance_type = "t2.micro"
  key_name = aws_key_pair.vtt.key_name
  security_groups = ["${aws_security_group.vtt-ingress.id}"]
  subnet_id = aws_subnet.vtt.id

  tags = {
    Name = "vtt"
  }
}

resource "aws_key_pair" "vtt" {
  key_name   = "vtt_key"
  public_key = var.public_key
}