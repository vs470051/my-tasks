Overview:

This Terraform code creates a robust and scalable AWS infrastructure consisting of a Virtual Private Cloud (VPC), two public subnets, two EC2 instances in each subnet, one Application Load Balancer (ALB) configured with EC2 instances in each subnet, two security groups (one for the ALB and another for EC2 instances), one Amazon Simple Storage Service (S3) bucket, and one Amazon Relational Database Service (RDS) with multi-Availability Zone (AZ) deployment.

Prerequisites:

Before running this Terraform code, ensure you have the following:

1)AWS CLI installed and configured with the necessary credentials.
2)Terraform installed on your local machine.
3)AWS account with the required permissions.
4)In this code i used custom ami image for the instance creation.Use your AWS ami images or your customed images

Directory Strucuture:

FathersShop/
│
├── main.tf
├── provider.tf
├── outputs.tf
└── modules/
    ├── vpc/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── ec2/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── alb/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── security_groups/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── s3/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── rds/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf


Configuration:

main.tf:
The main Terraform configuration file that orchestrates the deployment.

variables.tf
Defines the input variables required for the Terraform modules.

outputs.tf
Specifies the output variables that may be useful after the infrastructure is provisioned.

modules/
vpc/: Configures the Virtual Private Cloud with two public subnets.
ec2/: Deploys EC2 instances in each public subnet and creating a pem key and download in Root folder.
alb/: Sets up the Application Load Balancer with target groups along with creating the target groups and configuring them ec2 instances.
security_groups/: Configures security groups for ALB and EC2 instances.
s3/: Creates an private S3 bucket.
rds/: Deploys an RDS instance with multi-AZ configuration.


Usage:

  1)Clone this repository to your local machine.

  2)Modify the main.tf file to suit your requirements.

  Run the following commands in the terminal:
    1) terraform init
    2) terraform validate
    3) terraform plan
    4) terraform apply
 
  3)Confirm the changes when prompted.


Outputs:
After successful execution, Terraform will display the relevant outputs, such as ALB DNS name, EC2 instance IPs, RDS endpoint, etc.

Cleanup:

To destroy the infrastructure, run: terraform destroy

Confirm the destruction when prompted.

Note: 
1)Be cautious while running terraform destroy as it will delete all the resources created by Terraform.
2)In this Terraform code i passed the access key and secret as env variable you can also crediatial file or aws profile .

Additional Notes
Ensure proper AWS credentials are set up and Terraform has the required permissions.
Check AWS regional availability for certain services.
Customize the variables and configurations based on specific needs.



