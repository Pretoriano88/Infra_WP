variable "subnet_public_id_a" {

}
variable "subnet_public_id_b" {

}

variable "security_group_efs_id" {

}
// variables.tf
variable "subnet_ids" {
  description = "Lista de IDs das subnets onde os mount targets do EFS serão criados."
  type        = list(string)  // Define que a variável é uma lista de strings
}

variable "enviroment" {
  
}