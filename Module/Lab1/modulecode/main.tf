# module "rg_module" {
#   source = "../resourcegroup"
# }

module "sa_module" {
  depends_on = [ module.rg_module ]
  source = "../storageaccount"
}
