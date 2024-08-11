variable "rg_final" {}
module "rg_module" {
  source      = "../resourcegroup"
  rg_variable = var.rg_final
}

variable "vnet_final" {}
module "vnet_module" {
  depends_on    = [module.rg_module]
  source        = "../vnet"
  vnet_variable = var.vnet_final
}

variable "subnet_final" {}
module "subnet_module" {
  depends_on      = [module.rg_module, module.vnet_module]
  source          = "../subnet"
  subnet_variable = var.subnet_final
}

