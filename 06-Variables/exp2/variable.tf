variable "zones" {
  type = list(string)
  default = ["us-east-1a", "us-east-1b"]
}



variable "myname" {
  type = string
  default = "mydefault-instances"
}
