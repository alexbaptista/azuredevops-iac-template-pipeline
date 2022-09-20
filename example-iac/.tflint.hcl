config {
    plugin_dir = ".tflint.d/plugins"
    disabled_by_default = false
    ignore_module = {}
}
#### Default rules Terraform ####
rule "terraform_comment_syntax" { enabled = true }
rule "terraform_deprecated_index" { enabled = true }
rule "terraform_deprecated_interpolation" { enabled = true }
rule "terraform_documented_outputs" { enabled = true }
rule "terraform_documented_variables" { enabled = true }
rule "terraform_empty_list_equality" { enabled = true }
rule "terraform_module_pinned_source" { enabled = true }
rule "terraform_module_version" { enabled = true }
rule "terraform_naming_convention" { enabled = true }
rule "terraform_required_providers" { enabled = true }
rule "terraform_required_version" { enabled = true }
rule "terraform_standard_module_structure" { enabled = true }
rule "terraform_typed_variables" { enabled = true }
rule "terraform_unused_declarations" { enabled = true }
rule "terraform_unused_required_providers" { enabled = true }
rule "terraform_workspace_remote" { enabled = true }

#### Azure rules Terraform ####
plugin "azurerm" {
  enabled = true
  version = "0.17.1"
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}

rule "azurerm_kubernetes_cluster_default_node_pool_invalid_vm_size" { enabled = true }
rule "azurerm_kubernetes_cluster_invalid_name" { enabled = true }
rule "azurerm_kubernetes_cluster_node_pool_invalid_os_disk_size_gb" { enabled = true }
rule "azurerm_kubernetes_cluster_node_pool_invalid_os_type" { enabled = true }
rule "azurerm_kubernetes_cluster_node_pool_invalid_vm_size" { enabled = true }