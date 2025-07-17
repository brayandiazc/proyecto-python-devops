variable "aws_region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "id_rsa"
}

variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "my_ip" {
  description = "Tu IP pública con /32"
  default     = "152.204.154.254/32" # REEMPLAZA ESTO
}
