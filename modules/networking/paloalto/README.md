# Palo Alto NVA Build

The following README shows an example of building a Palo Alto NVA cluster using Azure public and private load-balancers
and can be used to inspect both east-west and north-south traffic.

This is not in reference to a single module, but instead using multiple modules to build a single solution.

## Default Naming Convention

n/a

## Example Settings
```yaml
# Key Vault is needed to store VM access keys
keyvaults:
  kv1:
    naming_convention:
      name_mask: "{name}"
    name: "seans1kv2connect2ncus"
    enabled: true
    resource_group_key: "admin"
    sku_name: standard

# SPN used will need "Get","List","Set","Delete","Purge" secret permissions to the KV
keyvault_access_policies:
  policy2:
    keyvault_key: "kv1"
    enabled: true
    object_id_policy: true
    object_id: "object-id-here"
    key_permissions: ["Get","List","Update","Create","Delete"]
    secret_permissions: ["Get","List","Set","Delete","Purge"]
    storage_permissions: ["Get","List","Update"]

# A storage account with a file share needs to be created in order to load the bootstrap files
# The storage and bootstrap settings are only needed if bootstrapping the NVAs,
# in which may or may not be required depending on client's requirements
storageaccounts:
  st1:
    enabled: true
    name: "seans0sta0ncus2paboot"
    resource_group_key: "networking"
    account_tier: Standard
    access_tier: Hot
    account_replication_type: LRS
    account_kind: StorageV2
    file_shares:
      fs01:
        name: "pa-bootstrap"
        quota: 1
        directories:
          dir01:
            name: "pa-bootstrap"

pa_bootstrap:
  pa_b1:
    enabled: true
    storage_account_key: "st1"
    file_share_key: "fs01"
    directory_key: "dir01"

networking:
# An NSG will need to be applied to any of the PA interfaces that have a public IP assigned
# It's recommended to keep this an open NSG on the interfaces inspecting traffic 
# Afterall, we're building firewalls here, so unless it's a highly secure enviroment 
# no need to inspect traffic multiple times
  network_security_groups:
    open_nsg:
      name: "OPEN"
      enabled: true
      resource_group_key: "networking"
      rules:
        rule100-in:
          name: "ALLOW-ALL-IN"
          priority: "100"
          direction: "Inbound"
          access: "Allow"
          protocol: "*"
          source_port_range: "*"
          destination_port_range: "*"
          source_address_prefix: "*"
          destination_address_prefix: "*"
        rule100-out:
          name: "ALLOW-ALL-OUT"
          priority: "100"
          direction: "Outbound"
          access: "Allow"
          protocol: "*"
          source_port_range: "*"
          destination_port_range: "*"
          source_address_prefix: "*"
          destination_address_prefix: "*"
# As for the NSG tied to the MGMT interfaces, let's be more restrictive, especially if a public IP is applied
    mgmt_nsg:
      name: "MGMT"
      enabled: true
      resource_group_key: "networking"
      rules:
        rule100-in:
          name: "ALLOW-FW-MGMT-INBOUND-SSH"
          priority: "100"
          direction: "Inbound"
          access: "Allow"
          protocol: "Tcp"
          source_port_range: "*"
          destination_port_range: "22"
          source_address_prefix: "50.159.75.84"
          destination_address_prefix: "*"
        rule110-in:
          name: "ALLOW-FW-MGMT-INBOUND-HTTPS"
          priority: "110"
          direction: "Inbound"
          access: "Allow"
          protocol: "Tcp"
          source_port_range: "*"
          destination_port_range: "443"
          source_address_prefix: "50.159.75.84"
          destination_address_prefix: "*"

  vnets:
    vnet1:
      naming_convention:
        postfix: "001"
      enabled: true
      resource_group_key: "networking"
      address_space: ["10.106.16.0/22"]
      subnets:
        subnet1:                 
          name: MGMT
          enabled: true
          address_prefixes: ["10.106.16.96/27"]
          # For PA's, applying NSGs to the interface is preferred over the subnet
          # nsg_key: "mgmt_nsg"
        subnet2:
          name: TRUST
          enabled: true
          address_prefixes: ["10.106.16.128/26"]
          # For PA's, applying NSGs to the interface is preferred over the subnet
          # nsg_key: "open_nsg"
        subnet3:                 
          name: UNTRUST
          enabled: true
          address_prefixes: ["10.106.17.0/27"]
          # For PA's, applying NSGs to the interface is preferred over the subnet
          # nsg_key: "open_nsg"

  public_ip_addresses:
    # If multiple, override the naming mask to apply postfix and/or add name to object
    pa-vm1-mgmt-pip:
      naming_convention:
        force_lowercase: true
      enabled: true
      resource_group_key: "networking"
      name: "pa-vm1-mgmt"
      allocation_method: Static
      sku: Standard
    pa-vm1-untrust-pip:
      naming_convention:
        force_lowercase: true
      enabled: true
      resource_group_key: "networking"
      name: "pa-vm1-untrust"
      allocation_method: Static
      sku: Standard
    pa-vm2-mgmt-pip:
      naming_convention:
        force_lowercase: true
      enabled: true
      resource_group_key: "networking"
      name: "pa-vm2-mgmt"
      allocation_method: Static
      sku: Standard
    pa-vm2-untrust-pip:
      naming_convention:
        force_lowercase: true
      enabled: true
      resource_group_key: "networking"
      name: "pa-vm2-untrust"
      allocation_method: Static
      sku: Standard

    # The following are assigned to the public load-balancer, and corresponds to inbound services that are being NAT'ed
    # on the PA NVAs
    piplb1:
      naming_convention:
        force_lowercase: true
      enabled: false
      resource_group_key: "networking"
      name: "lb1"
      allocation_method: Static
      sku: Standard
    piplb2:
      naming_convention:
        force_lowercase: true
      enabled: false
      resource_group_key: "networking"
      name: "lb2"
      allocation_method: Static
      sku: Standard

# Availability Zones are also supported if the region in which we're building the NVA's also supports it
# For this example, we'll use an Availability Set
availability_sets:
  avset1:
    enabled: true
    resource_group_key: "networking"
    naming_convention:
      postfix: "FW"

# Unsure how many active NVAs are supported in a cluster, so showing minimum of two for this example
virtual_machines:
  pa-vm1:
    resource_group_key: "networking"
    os_type: linux
    enabled: true
    provision_vm_agent: false   
    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key: "kv1"

    network_interfaces:
      mgmt-nic:
        vm_setting_key: "linux" #required for vm name lookup
        vnet_key: "vnet1"
        subnet_key: "subnet1"
        # NSGs defined on the interface level
        nsg_key: "mgmt_nsg"
        primary: true
        naming_convention:
          postfix: "MGMT"       
        enable_ip_forwarding: false
        public_ip_address_key: "pa-vm1-mgmt-pip"
      untrust-nic:
        vm_setting_key: "linux" #required for vm name lookup
        vnet_key: "vnet1"
        subnet_key: "subnet3"
        # NSGs defined on the interface level
        nsg_key: "open_nsg"
        naming_convention:
          postfix: "UNTRUST"       
        enable_ip_forwarding: true
        public_ip_address_key: "pa-vm1-untrust-pip"
      trust-nic:
        vm_setting_key: "linux" #required for vm name lookup
        vnet_key: "vnet1"
        subnet_key: "subnet2"
        # NSGs defined on the interface level
        nsg_key: "open_nsg"
        naming_convention:
          postfix: "TRUST"       
        enable_ip_forwarding: true

    virtual_machine_settings:
      linux:
        naming_convention:
          name_mask: "{name}"
        name: "PAFW-TST1" 
        availability_set_key: "avset1"
        # See PA docs for supported VM sizes. Smallest supported size is "Standard_D3_v2"
        size: "Standard_D3_v2"
        admin_username: "adminuser"
        admin_password: "some_secure_password"
        disable_password_authentication: false

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys: ["mgmt-nic","untrust-nic","trust-nic"]

        os_disk:
          caching: "ReadWrite"
          storage_account_type: "Standard_LRS"
        
        identity:
          type: "SystemAssigned" #SystemAssigned OR UserAssigned OR SystemAssigned, UserAssigned

        # the following two settings are only required if using PA bootstrap
        custom_data: "palo_alto_connection_string"
        palo_alto_connection_string: 
          storage_account: "st1"
          file_share: "fs01"
          file_share_directory: "dir01"
        
        source_image_reference:
          publisher: "paloaltonetworks"
          offer: "vmseries-flex"
          sku: "bundle1"
          version: "latest"

        plan:
          name: "bundle1"
          publisher: "paloaltonetworks"
          product: "vmseries-flex"
  pa-vm2:
    resource_group_key: "networking"
    os_type: linux
    enabled: true
    provision_vm_agent: false   
    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key: "kv1"

    network_interfaces:
      mgmt-nic:
        vm_setting_key: "linux" #required for vm name lookup
        vnet_key: "vnet1"
        subnet_key: "subnet1"
        primary: true
        naming_convention:
          postfix: "MGMT"       
        enable_ip_forwarding: false
        public_ip_address_key: "pa-vm2-mgmt-pip"
        # NSGs defined on the interface level
        nsg_key: "mgmt_nsg"
      untrust-nic:
        vm_setting_key: "linux" #required for vm name lookup
        vnet_key: "vnet1"
        subnet_key: "subnet3"
        # primary: false
        naming_convention:
          postfix: "UNTRUST"       
        enable_ip_forwarding: true
        public_ip_address_key: "pa-vm2-untrust-pip"
        # NSGs defined on the interface level
        nsg_key: "open_nsg"
      trust-nic:
        vm_setting_key: "linux" #required for vm name lookup
        vnet_key: "vnet1"
        subnet_key: "subnet2"
        # primary: false
        naming_convention:
          postfix: "TRUST"       
        enable_ip_forwarding: true
        # NSGs defined on the interface level
        nsg_key: "open_nsg"

    virtual_machine_settings:
      linux:
        naming_convention:
          name_mask: "{name}"
        name: "PAFW-TST2" 

        availability_set_key: "avset1"
        # See PA docs for supported VM sizes. Smallest supported size is "Standard_D3_v2"
        size: "Standard_D3_v2"
        admin_username: "adminuser"
        admin_password: "some_secure_password"
        disable_password_authentication: false

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys: ["mgmt-nic","untrust-nic","trust-nic"]

        os_disk:
          caching: "ReadWrite"
          storage_account_type: "Standard_LRS"
        
        identity:
          type: "SystemAssigned" #SystemAssigned OR UserAssigned OR SystemAssigned, UserAssigned

        # the following two settings are only required if using PA bootstrap
        custom_data: "palo_alto_connection_string"
        palo_alto_connection_string: 
          storage_account: "st2"
          file_share: "fs01"
          file_share_directory: "dir01"
        
        source_image_reference:
          publisher: "paloaltonetworks"
          offer: "vmseries-flex"
          sku: "bundle1"
          # version: "10.0.4"
          version: "latest"

        plan:
          name: "bundle1"
          publisher: "paloaltonetworks"
          product: "vmseries-flex"

load_balancers:
  pub_lb:
    enabled: true
    naming_convention:
      postfix: "PUB"
    resource_group_key: "networking"
    # "public" or "private"
    type: "public"
    # frontend IP configs are running off of a dynamic block, so config reference is a little different than the other config elements
    frontend:
      # the reference for this object is - frontend_index: 0 
      lbfe1:
        # we need either a pip_key: (public lb) or vnet_key: and subnet_key: (private lb) defined here
        pip_key: "piplb1"
        fe_ip_name: "FE1"
      # the reference for this object is - frontend_index: 1
      lbfe2:
        pip_key: "piplb2"
        fe_ip_name: "FE2"

    probes:
      # SSH is the recommended probe for the PA NVAs
      probe1:
        lb_probe_protocol: "Tcp"
        # required if above is set to "Http" or "Https"
        # lb_probe_uri: "/"
        port: 22
        enabled: true
        name_mask: "{name}"
        name: "PROBE1"

    rules:
      rule1: 
        # lb_rule_protocol: "Tcp","Udp", or "All"; "All" only supported for private LBs
        enabled: true
        lb_rule_protocol: "Tcp"
        frontend_port: 443
        backend_port: 443
        frontend_index: 0
        probe_key: probe1
        enable_floating_ip: true
        naming_convention:
          name_mask: "{name}"
        name: "RULE1"
      rule2:
        enabled: true
        lb_rule_protocol: "Tcp"
        frontend_port: 22
        backend_port: 22
        frontend_index: 1
        probe_key: probe1
        enable_floating_ip: true
        naming_convention:
          name_mask: "{name}"
        name: "RULE2"
      rule3:
        enabled: false
        lb_rule_protocol: "Udp"
        frontend_port: 53
        backend_port: 53
        frontend_index: 1
        probe_key: probe1
        naming_convention:
          name_mask: "{name}"
        name: "RULE3"

    backend_pool_assoc:
      assoc1:
        resource_key: "pa-vm1"
        nic_id_key: "untrust-nic"
        enabled: true
      assoc2:
        resource_key: "pa-vm2"
        nic_id_key: "untrust-nic"
        enabled: true

  trust_lb:
    enabled: true
    naming_convention:
      postfix: "TRUST"
    resource_group_key: "networking"
    type: "private"
    # frontend IP config running off of a dynamic block, so config reference is a little different than the other config elements
    frontend:
      lbfe1:
        fe_ip_name: "FE1"
        vnet_key: "vnet1"
        subnet_key: "subnet2"
        private_ip_address: "10.106.16.135"

    probes:
      # SSH is the recommended probe for the PA NVAs
      probe1:
        lb_probe_protocol: "Tcp"
        # required if above is set to "Http" or "Https"
        # lb_probe_uri: "/"
        port: 22
        enabled: true
        name_mask: "{name}"
        name: "PROBE1"
    rules:
      rule1: 
        # lb_rule_protocol: "Tcp","Udp", or "All"; "All" only supported for private LBs
        enabled: true
        lb_rule_protocol: "All"
        frontend_index: 0
        probe_key: probe1
        enable_floating_ip: true
        naming_convention:
        name: "RULE1"

    backend_pool_assoc:
      assoc1:
        resource_key: "pa-vm1"
        nic_id_key: "trust-nic"
        enabled: true
      assoc2:
        resource_key: "pa-vm2"
        nic_id_key: "trust-nic"
        enabled: true
```

## Example Module Reference

```yaml
# More specific examples can be found in the corresponding module READMEs
# The module calls below are for this specific PA NVA build example
module "resource_groups" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/resource_group"
  for_each = {
    for key, value in try(local.settings.resource_groups, {}) : key => value
    if try(value.reuse, false) == false && try(value.enabled, false) == true
  }

  resource_group_name = each.value.name
  resource_group      = each.value
  global_settings     = local.settings
  tags                = try(each.value.tags, null)
}

module "keyvault" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/security/keyvault"

  for_each = {
    for key, value in try(local.settings.keyvaults, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  key_vault           = each.value
  tenant_id           = var.tenant_id
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
}

module "keyvault_access_policies" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/security/keyvault_access_policies"

  for_each = {
    for key, value in try(local.settings.keyvault_access_policies, {}) : key => value
    if try(value.enabled, false) == true
  }

  keyvaults       = module.keyvault
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  access_policies = each.value
}

module "network_security_groups" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/network_security_group"

  for_each = {
    for key, value in try(local.settings.networking.network_security_groups, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == false
  }

  global_settings                   = local.settings
  resource_group_name               = local.resource_groups[each.value.resource_group_key].name
  network_security_group            = each.value
  # application_security_groups       = module.app_security_groups
  network_watchers                  = module.network_watchers
  diagnostics                       = local.diagnostics
  tags                              = try(each.value.tags, null)
}

module "networking" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/virtual_network"

  for_each = {
    for key, value in try(local.settings.networking.vnets, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == false
  }

  global_settings                   = local.settings
  resource_group_name               = local.resource_groups[each.value.resource_group_key].name
  virtual_network                   = each.value
  tags                              = try(each.value.tags, null)
}

module "public_ip_address" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/public_ip_addresses"

  for_each = {
    for key, value in try(local.settings.networking.public_ip_addresses, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  public_ip_address   = each.value
  tags                = try(each.value.tags, null)
}

# the next two modules are only required if utilizing PA bootstrap
module "storage_account" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/storage_account"

  for_each = {
    for key, value in try(local.settings.storageaccounts, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  storage_account     = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
}

module "pa_bootstrap_fileshare" {
  source               = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/paloalto/azure_bootstrap/"

  for_each = {
    for key, value in try(local.settings.pa_bootstrap, {}) : key => value
    if try(value.enabled, false) == true
  }

  storage_account_name = module.storage_account[each.value.storage_account_key].name
  storage_account_key  = module.storage_account[each.value.storage_account_key].primary_access_key
  storage_share_name   = module.storage_account[each.value.storage_account_key].file_share[each.value.file_share_key].name
  storage_dir_name     = module.storage_account[each.value.storage_account_key].file_share[each.value.file_share_key].file_share_directories[each.value.directory_key].name
  local_file_path      = "./paloalto/bootstrap_files/common_fw/"
}

module "availability_sets" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/compute/availability_set"
  for_each = {
    for key, value in try(local.settings.availability_sets, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  availability_set    = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
}

module "virtual_machines" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/compute/virtual_machine"
  for_each = {
    for key, value in try(local.settings.virtual_machines, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
  virtual_networks    = module.networking
  keyvaults           = module.keyvault
  availability_sets   = module.availability_sets
  public_ip_addresses = module.public_ip_address
  storage_accounts    = module.storage_account
  network_security_groups = module.network_security_groups
}

module "lb" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/load_balancer"
  for_each = {
    for key, value in try(local.settings.load_balancers, {}) : key => value
    if try(value.reuse, false) == false && try(value.enabled, false) == true
  }

  global_settings       = local.settings
  location              = local.settings.location
  tags                  = try(each.value.tags, null)
  resource_group_name   = try(each.value.rg_name, null) != null ? each.value.rg_name : try(each.value.resource_group_key, null) != null ? local.resource_groups[each.value.resource_group_key].name : null
  settings              = each.value
  type                  = try(each.value.type, null)
  backend_resources     = module.virtual_machines
  public_ips            = module.public_ip_address
  subnet_id             = module.networking
}

```

<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

<!-- END_TF_DOCS -->