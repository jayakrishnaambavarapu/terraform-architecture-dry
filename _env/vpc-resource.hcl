/*terraform {
   source = "tfr://registry.terraform.io/jayakrishnaambavarapu/ambavarapu-vpcmodule/aws?version=1.0.0"
}
*/

/* if you want to use same configuration for your prod environment, only difference is input variables, then instead of writing it in all prod environment like prod/vpc/terragrunt.hcl &
prod/subnet/terragrunt.hcl then we can define this common configuration in _env directory like _env/vpc.hcl & _env/subnet.hcl and reference it in prod/vpc/terragrunt.hcl using include blockand using get_terragrunt_dir() function.

Note: _env directory is made in root directory where root terragrunt.hcl file lives

*/

locals {
  source_base_url = "tfr://registry.terraform.io/jayakrishnaambavarapu/ambavarapu-vpcmodule/aws"
}

/* Note: common configuration about a environment is defined here in _env directory.
some times we want to use different version of a module or submodules in that as a source, instead of overriding source in prod/terragrunt.hcl file by defining terraform block, we can use 
locals, like above locals block, define the url over there in locals block but not provide any version to it and then use this locals block in prod/vpc/terragrunt.hcl file using 
include block.

example: prod/vpc/terragrunt.hcl

include "vpc-resource" {
  path = "${get_terragrunt_dir()}/../../_env/vpc-resource.hcl"
  expose = true
}

# in path we have mentioned path where to pick the data
# now we are using exposed includes to override common configurations.

terraform {
  source = "${include.vpc-resource.locals.source_base_url}//modules/module-a?version=1.0.0
} 

*/ 
