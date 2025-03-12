variable "region" {
  description = "AWS Region to deploy ec2 instance" 
  default     = "us-east-1"
}
variable "ami-id" {
  type        = string
  description = "AMI to use for the instance"
}
variable "default_tags" {
  type        =  map(string) 
  description = "Map of tags to assign to the Instance"
}
variable "instance-type" {
  type        = string
  description = "Instance type to use for the instance"
}
variable "key-name" {
  type        = string
  description = "Key name of the Key Pair to use for the instance"
  default     = ""
}
variable "vpc-security-group-ids" {
  type        = list(string)
  description = "List of security group IDs to associate with"
}

variable "associate-public-ip" {
  type        = bool
  description = "Whether to associate a public IP address with an instance in a VPC"
  default = false
}

variable "user-data" {
  type        = string
  description = "User data to provide when launching the instance"
  default     = ""
}
variable "vpc-id" {
  type        = string
  description = "ID of the VPC"
  default     = null
}
variable "disable-api-termination" {
  type        = bool
  description = "If true, enables EC2 Instance Termination Protection"
  default     = true
}
variable "enable-detailed-monitoring" {
  type        = bool
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  default     = true
}
#variable "instance-name" {
#  type        = string
#  description = "Name of the Instance"
#  default     = null
#}
variable "ebs_optimized" {
  type        = bool
  description = "If true, the launched EC2 instance will be EBS-optimized."
  default     = null 
}
variable "root-volume-size" {
  type        = number
  description = "Configuration block to customize details about the root block device of the instance"
  default     = 8
}
variable "instance-profile-name" {
  type        = string
  description = "The name of the instance profile for the ec2 instance to assume"
  default = null
}
variable "volume-type" {
  description = "Root volume type"
  default     = "gp2"
}
#variable "instance-count" {
#  type        = number
#  description = "The number of EC2 instances that should be deployed"
#}
variable "availability-zones" {
  type        = list(any)
  description = "AZ to start the instance in"
}
variable "az-to-subnet-mapping" {
  type        = map(string)
  description = "Mapping the availability zones to the corresponding subnets"
  //  default = {
  //    "availability-zone-1" = "subnet-id-1"
  //  }
}
variable "cpu-core-count" {
  type        = number
  description = "Sets the number of CPU cores for an instance. This option is only supported on creation of instance type that support CPU Options CPU Cores and Threads Per CPU Core Per Instance Type - specifying this option for unsupported instance types will return an error from the EC2 API"
  default     = 0
}

variable "cpu-threads-per-core" {
  type        = number
  description = "Optional - has no effect unless cpu_core_count is also set) If set to 1, hyperthreading is disabled on the launched instance. Defaults to 2 if not set"
  default     = 0
}
variable "ebs-volume-config" {
  type        = map(string)
  description = "A mapping of the volume configuration consiting of name,size,type,iops"
    default = {
   //   "volume-1" = "volume-name,volume-size,volume-type,volume-iops"
   //   "volume-2" = "/dev/sdg;10;gp2;0"
   //   "volume-3" = "/dev/sdf;10;io1;100"
   //   "volume-4" = "/dev/sdh;10;gp3;100;125"
    }
}
variable "ebs-force-detatch" {
  type        = bool
  description = "Forces the ebs volume to detach, be careful though as this can cause data loss"
}

variable "ebs-skip-destroy" {
  type        = bool
  description = "Set this to true if you do not wish to detach the volume from the instance to which it is attached at destroy time"
}
variable "environment" {
  type        = string
  description = "Name of the environment"
}
variable "kms-key-id" {
  type        = string
  description = "The ARN of the KMS key used to encrypt the EBS volumes"
  default     = ""
}
variable "role_arn" {
  type        = string
  description = "The ARN to assume the Role"
  default     = ""
}
variable "session_name" {
  type        = string
  description = "The session name for assuming role through STS"
  default     = ""
}
