provider "aws" {
  alias   = "US"
  version = "~>3.0"
  region  = "us-east-1"
}
provider "aws" {
  alias   = "sydney"
  version = "~>3.0"
  region  = "ap-southeast-2"
}