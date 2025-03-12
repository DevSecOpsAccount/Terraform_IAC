region = "us-east-2"
instance-type = "t2.micro"
ami-id = "ami-0430580de6244e02e"
key-name = "ec2key"
environment = "Production"
vpc-security-group-ids = ["sg-xxxxx"]
associate-public-ip = true
vpc-id = "vpc-66339e0d"
root-volume-size = 20
kms-key-id = ""
user_data = "init.sh"
#"${file("init.sh")}"
availability-zones = ["us-east-2a"]
az-to-subnet-mapping= {
             "us-east-2a" =  "subnet-xxxxx",
             "us-east-2b" =  "subnet-xxxxx"
}
ebs-volume-config = {
  #  "volume-1" = "/dev/sdg;30;gp2;0"
  #  "volume-2" = "/dev/sdf;10;io1;100"
  #  "volume-3" = "/dev/sdh;10;gp3;100;125"
}
ebs-skip-destroy = false
ebs-force-detatch = true
default_tags = {
    "Name" =  "Server"
    "Scope" = "Production"
}
role_arn = "arn:aws:iam::xxxxx:role/ec2-arn"
session_name = "ec2"