provider "aws" { 
  access_key = var.provider_access_key
  secret_key = var.provider_secret
  region = var.provider_region
}

resource "aws_instance" "main" {
  provisioner "local-exec" {
      command = "echo 'Hello World' > /Users/nkamboj/file.html"
  }

  provisioner "remote-exec" {
      inline = [
        "cd /var",
        "sudo mkdir -p www/html",
        "cd www/html",
        "sudo touch test.html"
      ]
  }

  provisioner "file" {
    source = "/Users/nkamboj/file.html"
    destination = "/var/www/html/test.html"
    on_failure = fail
  }

  connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file(var.aws_private_key_path)
      host = self.public_ip
  }

  ami = var.provider_ami
  instance_type = var.provider_instance_type
  key_name = var.provider_instance_key_name
}
