locals {
  vms = {
    VM1 = {
      os_type = "Linux"
      name    = "VM1"
    }
    VM2 = {
      os_type = "Linux"
      name    = "VM2"
    }
  }

  has_linux   = anytrue([for v in local.vms : v.os_type == "Linux"])
  has_windows = anytrue([for v in local.vms : v.os_type == "Windows"])
}
