provider "aws" {
  region = var.region
  # assume_role {
  # role_arn = var.role_arn
  # session_name = var.session_name
  # }
}

resource "aws_instance" "ec2-instance" {
  count = 1
  ami               = var.ami-id
  instance_type     = var.instance-type
  availability_zone = element(var.availability-zones, count.index)
  subnet_id = lookup(var.az-to-subnet-mapping, element(var.availability-zones, count.index), null)
  vpc_security_group_ids = var.vpc-security-group-ids
  key_name                    = var.key-name
  associate_public_ip_address = var.associate-public-ip
  user_data                   = var.user-data
  iam_instance_profile        = var.instance-profile-name
  ebs_optimized               = var.ebs_optimized 
  monitoring                  = var.enable-detailed-monitoring
  disable_api_termination     = var.disable-api-termination
  tags                        = var.default_tags

  root_block_device {
    volume_size = var.root-volume-size
    volume_type = var.volume-type
    encrypted     = true
  }
  metadata_options {
       http_endpoint = "enabled"
       http_tokens   = "required"
  }
  lifecycle {
    ignore_changes = [tags, ebs_optimized, ami,]
  }
}

resource "aws_ebs_volume" "ebs-volume" {
  count = var.instance-count * length(var.ebs-volume-config)

  availability_zone = element(aws_instance.ec2-instance[*].availability_zone, floor(count.index / length(var.ebs-volume-config)))

  type = element(split(";", element(values(var.ebs-volume-config), count.index)),2,)
  
  size = element(split(";", element(values(var.ebs-volume-config), count.index)),1,)
  
  iops = tonumber(element(split(";", element(values(var.ebs-volume-config), count.index)),3, ))
  throughput = element(
    split(";", element(values(var.ebs-volume-config), count.index)),
    2,
    ) != "gp3" ? null : element(
    split(";", element(values(var.ebs-volume-config), count.index)),
    4,
  )
  encrypted  = "true"
  kms_key_id = var.kms-key-id
  tags = merge({
    environment       = var.environment
    ec2_instance_id = aws_instance.ec2-instance[floor(count.index / length(var.ebs-volume-config))].id})
}


resource "aws_volume_attachment" "ebs-volume-attachment" {
  count = var.instance-count * length(var.ebs-volume-config) 

  device_name = element(split(";", element(values(var.ebs-volume-config), count.index)),0,)

  volume_id   = aws_ebs_volume.ebs-volume[count.index].id
  instance_id = aws_instance.ec2-instance[floor(count.index / length(var.ebs-volume-config))].id

  skip_destroy = var.ebs-skip-destroy
  force_detach = var.ebs-force-detatch
}
# resource "null_resource" "ex" {
#   provisioner "local-exec" {
#      command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.ec2-instance[0].id} && aws ec2 stop-instances --instance-ids ${aws_instance.ec2-instance[0].id} && aws ec2 wait instance-stopped --instance-ids ${aws_instance.ec2-instance[0].id} && aws ec2 modify-instance-metadata-options --instance-id  ${aws_instance.ec2-instance[0].id} --http-tokens required --http-endpoint enabled && aws ec2 start-instances --instance-ids ${aws_instance.ec2-instance[0].id}"
#   }
# }
