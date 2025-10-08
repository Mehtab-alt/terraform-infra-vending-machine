// variables.tf

# This is the "Name" input slot on our machine's control panel.
# It is a required input as it has no default value.
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

# This is the "Location" dial. No default is provided, forcing each
# environment's .tfvars file to explicitly define it.
variable "location" {
  type        = string
  description = "The Azure region where the resources will be created."
}

# This is the "Tags" panel for adding custom labels.
# It includes a validation rule to ensure the 'environment' tag is always present.
variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the resources."

  validation {
    condition     = contains(keys(var.tags), "environment")
    error_message = "The 'tags' map must contain an 'environment' key."
  }
}
