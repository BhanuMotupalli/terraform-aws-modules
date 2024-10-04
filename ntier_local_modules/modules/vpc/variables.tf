variable "vpc_info" {
  type = object({
    cidr_block           = string
    enable_dns_hostnames = bool
    tags                 = map(string)
  })

}

variable "public_subnets" {
  type = object({
    cidr_block = string
    az         = string
    tags       = map(string)
  })

}

variable "private_subnets" {
  type = object({
    cidr_block = string
    az         = string
    tags       = map(string)
  })

}