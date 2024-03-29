# Creating public aws ec2 instance with web server
resource "aws_instance" "public" {
  count                       = length(var.public_subnet_ids)
  ami                         = var.ami_id
  key_name                    = aws_key_pair.mykeypair.key_name
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_ids[count.index]
  vpc_security_group_ids      = [aws_security_group.public.id]
  associate_public_ip_address = true
  tags = {
    Name = "${var.env}-public-${count.index}"
  }

  # depends_on = [ var.s3_id ] // dependency on s3\
  
  user_data = <<EOF
#!bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>HELLO WORLD FROM $(hostname -f)</h1>" > /var/www/html/index.html
systemctl restart httpd
  EOF
}

# Creating private aws ec2 instance
resource "aws_instance" "private" {
  count                       = length(var.private_subnet_ids)
  ami                         = var.ami_id
  key_name                    = aws_key_pair.mykeypair.key_name
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_ids[count.index]
  vpc_security_group_ids      = [aws_security_group.private.id]
  associate_public_ip_address = false
  tags = {
    Name = "${var.env}-private-${count.index}"
  }
  # depends_on = [ var.s3_id ] // dependency on s3
}
