
locals {

  resource_name_map = {
    #global settings
    delimiter    = "${local.delimiter}"
    postfix      = "${local.postfix}"
    cloudprefix  = "${var.global_settings.naming.cloudprefix}"
    envlabel     = "${var.global_settings.naming.envlabel}"
    locationcode = "${var.global_settings.naming.locationcode}"

    #global settings resource group labels
    rgName   = "${try(var.settings.name, "")}"
    rgSuffix = "${var.global_settings.naming.rgsuffix}"

    #global settings resource labels
    aadds                      = lookup(var.global_settings.naming.resourcelabels, "aadds", "AADDS")
    app_config                 = lookup(var.global_settings.naming.resourcelabels, "app_config", "APPCS")
    app_insights               = lookup(var.global_settings.naming.resourcelabels, "app_insights", "APPI")
    app_service_plan           = lookup(var.global_settings.naming.resourcelabels, "app_service_plan", "PLAN")
    app_service_env            = lookup(var.global_settings.naming.resourcelabels, "app_service_env", "ASE")
    asg                        = lookup(var.global_settings.naming.resourcelabels, "asg", "ASG")
    automationacct             = lookup(var.global_settings.naming.resourcelabels, "automationacct", "AA")
    avd                        = lookup(var.global_settings.naming.resourcelabels, "avd", "AVD")
    avset                      = lookup(var.global_settings.naming.resourcelabels, "avset", "AS")
    azfirewall                 = lookup(var.global_settings.naming.resourcelabels, "azfirewall", "AZFW")
    azfirewallpolicy           = lookup(var.global_settings.naming.resourcelabels, "azfirewallpolicy", "AZFW-POLICY")
    azfirewallpolicyrcg        = lookup(var.global_settings.naming.resourcelabels, "azfirewallpolicyrcg", "AZFW-POLICY-RCG")
    azfirewallpolicynetrule    = lookup(var.global_settings.naming.resourcelabels, "azfirewallpolicynetrule", "NETWORK-RC")
    azfirewallpolicyapprule    = lookup(var.global_settings.naming.resourcelabels, "azfirewallpolicyapprule", "APPLICATION-RC")
    azfirewallpolicynatrule    = lookup(var.global_settings.naming.resourcelabels, "azfirewallpolicynatrule", "DNAT-RC")
    bastion                    = lookup(var.global_settings.naming.resourcelabels, "bastion", "BAS")
    data_factory               = lookup(var.global_settings.naming.resourcelabels, "data_factory", "ADF")
    datadisk                   = lookup(var.global_settings.naming.resourcelabels, "datadisk", "DataDisk")
    dnszonevnetlink            = lookup(var.global_settings.naming.resourcelabels, "dnszonevnetlink", "DNSZONEVNETLNK")
    erg                        = lookup(var.global_settings.naming.resourcelabels, "erg", "ERG")
    expressrouteport           = lookup(var.global_settings.naming.resourcelabels, "expressrouteport", "ERP")
    expressroutecircuit        = lookup(var.global_settings.naming.resourcelabels, "expressroutecircuit", "ERC")
    expressroutecircuitpeering = lookup(var.global_settings.naming.resourcelabels, "expressroutecircuitpeering", "ERCP")
    expressroutecircuitauth    = lookup(var.global_settings.naming.resourcelabels, "expressroutecircuitauth", "ERCA")
    expressroutecircuitconn    = lookup(var.global_settings.naming.resourcelabels, "expressroutecircuitconn", "ERCConn")
    expressrouteconnection     = lookup(var.global_settings.naming.resourcelabels, "expressrouteconnection", "ERConn")
    function_app               = lookup(var.global_settings.naming.resourcelabels, "function_app", "FUNC")
    ipgroup                    = lookup(var.global_settings.naming.resourcelabels, "ipgroup", "IPGRP")
    keyvault                   = lookup(var.global_settings.naming.resourcelabels, "keyvault", "KV")
    lb                         = lookup(var.global_settings.naming.resourcelabels, "lb", "LB")
    lbprobe                    = lookup(var.global_settings.naming.resourcelabels, "lbprobe", "LBPROBE")
    lbrule                     = lookup(var.global_settings.naming.resourcelabels, "lbrule", "LBRULE")
    lng                        = lookup(var.global_settings.naming.resourcelabels, "lng", "LNG")
    lock                       = lookup(var.global_settings.naming.resourcelabels, "lock", "LOCK")
    loganalytics               = lookup(var.global_settings.naming.resourcelabels, "loganalytics", "LA")
    logic_app                  = lookup(var.global_settings.naming.resourcelabels, "logic_app", "LOGIC")
    mlci                       = lookup(var.global_settings.naming.resourcelabels, "mlci", "MLCI")
    mlwksp                     = lookup(var.global_settings.naming.resourcelabels, "mlwksp", "MLW")
    mssql_mi                   = lookup(var.global_settings.naming.resourcelabels, "mssql_mi", "SQLMI")
    mssql_server               = lookup(var.global_settings.naming.resourcelabels, "mssql_server", "SQL")
    mssql_server_elastic_pool  = lookup(var.global_settings.naming.resourcelabels, "mssql_server_elastic_pool", "SQLElasticPool")
    networkwatcher             = lookup(var.global_settings.naming.resourcelabels, "networkwatcher", "NetworkWatcher")
    nic                        = lookup(var.global_settings.naming.resourcelabels, "nic", "NIC")
    nsg                        = lookup(var.global_settings.naming.resourcelabels, "nsg", "NSG")
    nsgflowlogs                = lookup(var.global_settings.naming.resourcelabels, "nsgflowlogs", "NSGFlowLog")
    osdisk                     = lookup(var.global_settings.naming.resourcelabels, "osdisk", "OSDisk")
    p2svpn                     = lookup(var.global_settings.naming.resourcelabels, "p2svpn", "P2SVPN")
    privateendpoint            = lookup(var.global_settings.naming.resourcelabels, "privateendpoint", "pe")
    publicip                   = lookup(var.global_settings.naming.resourcelabels, "publicip", "PIP")
    publicip_prefix            = lookup(var.global_settings.naming.resourcelabels, "publicip_prefix", "PRFX")
    routefilter                = lookup(var.global_settings.naming.resourcelabels, "routefilter", "RF")
    route_server               = lookup(var.global_settings.naming.resourcelabels, "routetable", "RT")
    routetable                 = lookup(var.global_settings.naming.resourcelabels, "routetable", "RS")
    rsv                        = lookup(var.global_settings.naming.resourcelabels, "rsv", "RSV")
    sbus_ns                    = lookup(var.global_settings.naming.resourcelabels, "sbus_ns", "SB")
    sbus_ns_auth_rule          = lookup(var.global_settings.naming.resourcelabels, "sbus_ns_auth_rule", "SBAuthRule")
    subnet                     = lookup(var.global_settings.naming.resourcelabels, "subnet", "SNET")
    user_assigned_id           = lookup(var.global_settings.naming.resourcelabels, "mi", "MI")
    vhub                       = lookup(var.global_settings.naming.resourcelabels, "vhub", "VHUB")
    vmss                       = lookup(var.global_settings.naming.resourcelabels, "vmss", "VMSS")
    vnet                       = lookup(var.global_settings.naming.resourcelabels, "vnet", "VNET")
    vng                        = lookup(var.global_settings.naming.resourcelabels, "vng", "VNG")
    vngc                       = lookup(var.global_settings.naming.resourcelabels, "vngc", "VNGConn")
    vpng                       = lookup(var.global_settings.naming.resourcelabels, "vpng", "VPNG")
    vwan                       = lookup(var.global_settings.naming.resourcelabels, "vwan", "VWAN")

    #resource specific settings    
    name               = "${var.name == null ? try(var.settings.name, "") : var.name}"
    vmnameprefix       = "${var.global_settings.naming.vmnameprefix}"
    referenced_name    = "${try(var.referenced_name, "")}"
    referenced_name_1  = "${try(var.referenced_name_1, "")}"
    object_name_prefix = "${try(var.object_name_prefix, "")}"
    object_count       = "${try(var.object_count, "")}"

    vnet_address_space    = can(var.settings.address_space[0]) ? replace("${try(var.settings.address_space[0], "")}", "/", "_") : ""
    snet_address_prefixes = can(var.settings.address_prefixes[0]) ? replace("${try(var.settings.address_prefixes[0], "")}", "/", "_") : ""
  }

  # naming_convention = {
  #   delimiter = lookup(try(var.settings.naming_convention, {}), "delimiter", null) == null ? try(var.global_settings.naming_convention.delimiter, local.delimiter_default) : var.settings.naming_convention.delimiter}
  #   postfix = 
  #   force_lowercase = 
  #   force_uppercase = 
  # }

  #This is a last resort failsafe delimiter
  delimiter_default = "-"

  delimiter = lookup(try(var.settings.naming_convention, {}), "delimiter", null) == null ? lookup(try(var.global_settings.naming.naming_convention, {}), "delimiter", local.delimiter_default) : lookup(try(var.settings.naming_convention, {}), "delimiter", local.delimiter_default)

  postfix = lookup(try(var.settings.naming_convention, {}), "postfix", null) == null && length(regexall("{postfix}", var.name_mask)) > 0 ? tostring(random_integer.default_postfix[0].result) : lookup(try(var.settings.naming_convention, {}), "postfix", null)

  #something to stew on if we ever want to look into a counter
  #postfix = try(var.settings.vnet.naming_convention.postfix, format("%00d", var.index + 1))

  #This bad boy holds the semi-final result exluding the forced upper/lowercase
  name_result_temp = replace(format(
    replace(var.name_mask, "/{(${join("|", keys(local.resource_name_map))})}/", "%s"),
    [
      for value in flatten(regexall("{(${join("|", keys(local.resource_name_map))})}", var.name_mask)) :
      lookup(local.resource_name_map, value)
    ]...
  ), "/", "_")

  name_result = lookup(try(var.global_settings.naming.naming_convention, {}), "force_lowercase", false) == true || lookup(try(var.settings.naming_convention, {}), "force_lowercase", false) == true ? lower(local.name_result_temp) : lookup(try(var.global_settings.naming.naming_convention, {}), "force_uppercase", false) == true || lookup(try(var.settings.naming_convention, {}), "force_uppercase", false) == true ? upper(local.name_result_temp) : local.name_result_temp


}

resource "random_integer" "default_postfix" {
  min   = 1
  max   = 100
  count = lookup(try(var.settings.naming_convention, {}), "postfix", null) == null && length(regexall("{postfix}", var.name_mask)) > 0 ? 1 : 0

  # keepers (Map of String) Arbitrary map of values that, when changed, will trigger recreation of resource
  # keepers = {
  #   # Generate a new integer each time we switch to a new virtual_machine
  #   virtual_machine = "${var.virtual_machine}"
  # }
}
