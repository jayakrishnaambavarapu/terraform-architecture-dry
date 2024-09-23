/*include "root" {
   path = find_in_parent_folders()
}

include "vpc-resource" {
  path = "${get_terragrunt_dir()}/../../_env/vpc-resource.hcl"
}

# terraform {
#      source = "tfr://registry.terraform.io/jayakrishnaambavarapu/ambavarapu-vpcmodule/aws?version=2.0.0
#   }




inputs = {
  cidr = "10.10.0.0/16"
}

*/

/* Note: in terragrunt-architecture-dry/prod/vpc/terragrunt.hcl file we have written terraform block again because in terragrunt-architecture-dry/_env/vpc-resource.hcl file we have used one
version and in this prod/vpc/terragrunt.hcl file we want to use different version, so to override it i am using terraform block again this file to override the 
terragrunt-architecture-dry/_env/vpc-resource.hcl

this method is one of the ways to override the versions.

*/

# another way to override the versions is using exposed includes to override common configurations.

include "root" {
  path = find_in_parent_folders()
}

include "vpc-resource" {
  path = "${get_terragrunt_dir()}/../../_env/vpc-resource.hcl"
  expose = true
}

terraform {
  source = "${include.vpc-resource.locals.source_base_url}//modules/module-a?version=1.0.0"
}

inputs = {
  cidr-block-1 = "10.20.0.0/16"
}


