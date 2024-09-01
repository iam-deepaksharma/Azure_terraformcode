variable "rg_final" {}
module "rg_module" {
  source      = "../resourcegroup"
  rg_variable = var.rg_final
}

variable "sa_final" {}
module "storage_module" {
  depends_on  = [module.rg_module]
  source      = "../storageaccount"
  sa_variable = var.sa_final
}
