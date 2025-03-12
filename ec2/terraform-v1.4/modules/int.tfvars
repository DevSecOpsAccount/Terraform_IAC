role_arn = "arn:aws:iam::508126907316:role/GitLab_Authentication_Role"
session_name = "GitHubActions"
region = "us-east-1"
instance-type = "t2.micro"
ami-id = "ami-0e731c8a588258d0d"
key-name = "ec2keygitlab"
environment = "init"
vpc-security-group-ids = ["sg-0aa5ee36d1eb129e1"]
associate-public-ip = false
vpc-id = "vpc-0596107af69f37181"
root-volume-size = 20
kms-key-id = "arn:aws:kms:us-east-1:508126907316:key/582e8327-82b2-4064-8018-868541cebd08"
# user_data = "init.sh"
#"${file("init.sh")}"
availability-zones = ["us-east-1a"]
az-to-subnet-mapping= {
      "us-east-1a" =  "subnet-0191df03611809bc5",
      "us-east-1b" =  "subnet-01456cef6cdc8ee80"
}
ebs-volume-config = {
  "volume-1" = "/dev/sdg;30;gp2;0"
  "volume-2" = "/dev/sdf;10;io1;100"
  "volume-3" = "/dev/sdh;10;gp3;3000;125"
}
ebs-skip-destroy = false
ebs-force-detatch = true
default_tags = {
    "Name" =  "Server"
    "Scope" = "Production"
}
