variable "AWS_REGION" {
  default = "eu-west-1"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "C:\\Code\\frgtest\\mykey.txt"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "C:\\Code\\frgtest\\mykeyspub.txt"}
variable "ECS_INSTANCE_TYPE" {
  default = "t2.micro"
}
variable "ECS_AMIS" {
  type = "map"
  default = {
    eu-west-1 = "ami-4dd07434"
  }
}


variable "AMIS" {
  type = "map"
  default = {
    eu-west-1 = "ami-4dd07434"
  }
}
variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}
variable "WP_VERSION" {
  default = "12.06"
}

