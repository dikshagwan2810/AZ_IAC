variable "rg_name" {
    type = string
    description = "Azure Service account of terraform File execution"
}
variable "location" {
    type = string
    description = "Azure Service account of terraform File execution"
}
variable "client_id" {
    type = string
    description = "Azure Service account of terraform File execution"
}
variable "client_secret" {
    type = string
    description = "Azure Service account of terraform File execution"
}
variable "tenant_id" {
    type = string
    description = "Azure Service account of terraform File execution"
}
variable "subscription" {
    type = string
    description = "Azure Service account of terraform File execution"
}

variable "vnet_name" {
    type = string
    description = "Azure Service account of terraform File execution"
}
variable "vnet_cidr" {
    type = string
    description = "Azure Service account of terraform File execution"
}
variable "snet1_name" {
    type = string
    description = "Azure Service account of terraform File execution"
}
variable "snet1_cidr" {
    type = string
    description = "Azure Service account of terraform File execution"
}
variable "snet2_name" {
    type = string
    description = "Azure Service account of terraform File execution"
}
variable "snet2_cidr" {
    type = string
    description = "Azure Service account of terraform File execution"
    default =  ""
}
variable "aks_name" {
    type = string
    description = "Azure Service account of terraform File execution"
}
variable "aks_node_count" {
  type = number
}

variable "aks_node_size" {
  type = string
}

variable "acr_name" {
    type = string
    description = "Azure Service account of terraform File execution"
    default =  ""
}

variable "ssh_public_key" {
  default = ""
}






