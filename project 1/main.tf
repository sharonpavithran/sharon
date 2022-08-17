module "vpc" {
  source = "./vpc_module"
  count  = 4
  providers = {
    aws = aws.US
  }
}
module "vpc1" {
  source = "./vpc_module"
  count = 4
  providers = {
    aws = aws.sydney
  }
}