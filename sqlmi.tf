

data "template_file" "ssmi_server" {
  template = "${file("./templates/sqlmi.json")}"
}

resource "azurerm_template_deployment" "ssmi_server-tpl-deploy" {
  name                = "${var.AppName}${var.LOB}ssmiserverdeploy"
  resource_group_name = "${azurerm_resource_group.sqlmirg.name}"

  template_body = "${data.template_file.ssmi_server.rendered}"

  # these key-value pairs are passed into the ARM Template's `parameters` block
  parameters {
    "location" = "${var.azure_region}"
    "addressPrefix" = "10.0.0.0/16"
    "subnetPrefix" = "10.0.0.0/24"
    "skuName" = "GP_Gen4"
    "skuEdition" = "GeneralPurpose"
    "managedInstanceName" = "${var.AppName}${var.LOB}ssmi"
    "administratorLogin" = "sqlmiadmin"
    "administratorLoginPassword" = "${random_string.password.result}"
    #"storageSizeInGB" = 320
    #"vCores" = 8
    #"licenseType" = "LicenseIncluded"
    "licenseType" = "BasePrice"
    "hardwareFamily" = "Gen4"
    "collation" = "SQL_Latin1_General_CP1_CI_AS"
  }
  deployment_mode = "Incremental"
}
