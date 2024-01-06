# Resource Naming - Custom Avanade Naming Module

### Purpose

The `resource_naming` module is a custom module built by Avanade. The module dynamically builds a resource name by replacing placeholder values with global variables from settings.yaml and default local values from the `resource_naming` module.

### Global Variables

### `naming`

By default, "most" resources will have default names dynamically built if not overridden. Example resource names are provided in the respective Terraform module README.md file.

The following global variables are generally referenced in every resource module that contains a default `name_mask`.
```yaml
naming:
  cloudprefix: AVA
  locationcode: EUS2
  envlabel: DEV
```

Most resource modules require a **`name`** attribute which is used in combination with the global variables. There are cases where a resource does not require a `name` attribute as well as limited cases where a resource only uses the `name` attribute as its explicit value, ignoring other global variables. Again, please reference the respective Terraform module README.md file for an example.

**Example `name` attribute:**
```yaml
resource_groups:
  testrg:
    name: "Test_RG_Default"
```

### Default `name_mask`

Each Terraform module contains a local `name_mask` attribute which contains the ***default*** placeholders used to build the resources name. It's best to review this local variable to see if a `{name}` attribute is used to build the name. If **`{name}`** is in the **`name_mask`**, the settings.yaml file needs to have a `name` attribute nested under the object. In cases where the `name` attribute is the only placeholder used to build a resource name, the module's local `name_mask` variable will be **`name_mask: "{name}"`**

### Settings.yaml Resource Objects `naming_convention`

The `naming_convention` block is an optional block that when specified, will allow the user to override default naming placeholders. This block can be specified within an objects root level (i.e. two spaces indented from the resource object key)

**This block can contain the following optional attributes:**

Attribute Name|Type|Default
--------------|----|--|
**`name_mask`**|string|***set in module's local name_mask variable***
**`postfix`**|integer converted to string|random 2 digit integer converted to string
**`delimiter`**|string|**hyphen** ( - ) character
**`force_lowercase`**|boolean|false
**`force_uppercase`**|boolean|false

**Using the `naming_convention` block**

```yaml
naming:
  cloudprefix: AVA
  locationcode: EUS2
  envlabel: DEV

resource_groups:
  testrg:
    naming_convention:
      name_mask: "OVERRIDING{delimiter}{envlabel}{delimiter}{name}{postfix}"
      postfix: "001"
      delimiter: "#"
      force_lowercase: true
    enabled: true
    name: "TEST_rg_VALUE"
  devrg:
    enabled: true
    name: "mygroup"
```

**Example resource outputs**

Resource Object|Overridding default name_mask|Resource Name Result
---------------|-----------------------|------|
testrg|yes|**overriding#dev#test_rg_value001**
prodrg|no|AVA-EUS2-DEV-mygroup-RG

***To override a default `name_mask` with a custom set of placeholder values, use the following guidance***

Within an objects root level (i.e. two spaces indented from the resource object key), place a `naming_convention` block with a `name_mask` attribute. The value can be a series of placeholder values surrounded by curly backets. All placeholder values are defined in the `resource_naming` **module.tf** local variables.

For example, let's take the Log Analytics resource default name_mask:

**name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{loganalytics}"**

If there was a requirement to reorder the placeholders and remove the cloud prefix, you could do something like the following:

**Example:**
```yaml
log_analytics:
  laworkspace1:
    naming_convention:
      name_mask: "{envlabel}{delimiter}{loganalytics}{delimiter}{locationcode}"
    enabled: true
  laworkspace2:
    enabled: true
```

### Using Explicit Name Value for a Resource

Within an objects root level (i.e. two spaces indented from the resource object key), place a `naming_convention` block with `name_mask: "{name}"` and add a `name: "RESOURCE_NAME_GOES_HERE"` property to the root of the object with the exact value of the name you wish to use.

**Example: Resource Name Value = "LA_RESOURCE_NAME_TO_BE_USED"**

```yaml
naming:
  cloudprefix: AVA
  locationcode: EUS2
  envlabel: DEV

log_analytics:
  laworkspace1:
    naming_convention:
      name_mask: "{name}"
    enabled: true
    name: "LA_RESOURCE_NAME_TO_BE_USED"
  laworkspace2:
    enabled: true
```

**Example resource outputs**

Resource Object|Overridding default name_mask|Resource Name Result
---------------|-----------------------|------|
laworkspace1|yes|**LA_RESOURCE_NAME_TO_BE_USED**
laworkspace2|no|AVA-EUS2-DEV-LA

<br>
<br>
<br>
<br>
<br>
<br>

## Using resource_naming module in a Terraform module

```yaml
locals {
  name_mask = "{envlabel}{delimiter}{rgName}{delimiter}{rgSuffix}"
}

module "resource_naming" {
  source = "../resource_naming"

  global_settings = var.global_settings
  settings        = var.resource_group
  resource_type   = "azurerm_resource_group"
  name_mask       = try(var.resource_group.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_resource_group" "rg" {
  name     = module.resource_naming.name_result
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_integer.default_postfix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Set name outside of normal settings | `string` | `null` | no |
| <a name="input_name_mask"></a> [name\_mask](#input\_name\_mask) | Naming convention taken either from the default resource local var or overridden per resource in settings | `string` | `null` | no |
| <a name="input_object_count"></a> [object\_count](#input\_object\_count) | Custom object count used when overriding name\_masks such as VMs | `number` | `0` | no |
| <a name="input_object_name_prefix"></a> [object\_name\_prefix](#input\_object\_name\_prefix) | Custom object name prefix used when overriding name\_masks such as VMs | `string` | `null` | no |
| <a name="input_referenced_name"></a> [referenced\_name](#input\_referenced\_name) | Pass another objects name to the module to be associated or joined with current name | `string` | `null` | no |
| <a name="input_referenced_name_1"></a> [referenced\_name\_1](#input\_referenced\_name\_1) | Pass another objects name to the module to be associated or joined with current name | `string` | `null` | no |
| <a name="input_resource_type"></a> [resource\_type](#input\_resource\_type) | Resource Type - to be used in any conditional evaluations in the module | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | The naming convention settings object used to override defaults | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_delimiter"></a> [delimiter](#output\_delimiter) | The Name Mask Delimiter used to build the output.name\_result |
| <a name="output_name_mask"></a> [name\_mask](#output\_name\_mask) | The Name Mask used to build the output.name\_result |
| <a name="output_name_result"></a> [name\_result](#output\_name\_result) | The Name of the resource referencing this module |
| <a name="output_name_result_temp"></a> [name\_result\_temp](#output\_name\_result\_temp) | The Temporary Name for the resource referencing this module |
| <a name="output_postfix"></a> [postfix](#output\_postfix) | The Name Mask Postfix (usually an integer) used to build the output.name\_result |
<!-- END_TF_DOCS -->