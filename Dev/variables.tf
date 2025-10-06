
# Azure Resource Group and Location
variable "rgname" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure location/region for the AKS cluster"
  type        = string
}

variable "keyvault_name" {
  description = "Name of the keyvault"
  type        = string
}
variable "SUB_ID" {
  type        = string
}
variable "service_principal_name" {
  type        = string 
} 
# AKS Cluster Config
variable "cluster_name" {
}


variable "node_pool_name" {
  description = "Node pool name"
  }