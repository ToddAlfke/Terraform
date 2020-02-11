resource "aws_instance" "testInstance" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.subnet_public.id
  vpc_security_group_ids = [aws_security_group.sg_22.id]
  key_name = aws_key_pair.ec2key.key_name
 tags = {
  Name = var.environment_tag
 }
 provisioner "file" {
  source      = "script.sh"
  destination = "/tmp/script.sh"
}
provisioner "remote-exec" {
   inline = [
     "chmod +x /tmp/script.sh",
     "/tmp/script.sh args",
   ]
 }
}
