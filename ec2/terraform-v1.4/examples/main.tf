# Below two methods of authentication are provided. One is to use roles to get authenticated and the other is to use keys. Once a choice is 
# made about which authentication to use, Please comment on the other one. 


# If you want to authenticate using assume role, Please use below mentioned.
#provider "aws" {
#  region     = var.region
#  assume_role {
#    role_arn = var.role_arn
#    session_name = var.session_name
# }
#}

#If you want to authenticate using keys, Please use below mentioned.
provider "aws" {
  region = var.region
  # access_key = ""

  # secret_key = ""

}


module "ec2" {
  source                 = "../modules"
  instance-type          = var.instance-type
  ami-id                 = var.ami-id
  key-name               = var.key-name
  environment            = var.environment
  vpc-security-group-ids = var.vpc-security-group-ids
  associate-public-ip    = var.associate-public-ip
  vpc-id                 = var.vpc-id
  root-volume-size       = var.root-volume-size
  user-data              = "../modules/init.sh"
  #"${file("../modules/init.sh")}"
  availability-zones   = var.availability-zones
  kms-key-id           = var.kms-key-id
  az-to-subnet-mapping = var.az-to-subnet-mapping
  ebs-volume-config    = var.ebs-volume-config
  ebs-skip-destroy     = var.ebs-skip-destroy
  ebs-force-detatch    = var.ebs-force-detatch
  default_tags         = var.default_tags
}
