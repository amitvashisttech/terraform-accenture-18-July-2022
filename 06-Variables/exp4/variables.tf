variable "usernumber" {
  type = number
  default = "01"
}

variable "elb_name" {
  type = string
  default = "defaultelb"
}

variable "region" {
  type = string
  default = "us-east-1"
}

variable "az" {
  type = list
  default = ["us-east-1a", "us-east-1b"]
}

variable "timeout" {
  type = number
  default = "100"
}

