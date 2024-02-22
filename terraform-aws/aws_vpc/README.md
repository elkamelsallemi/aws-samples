
The Terraform resource block configures various settings for Terraform. Starting with Terraform version 13.0, the __required_providers__ block was introduced to describe the version and source of Terraform providers.

Providers allow Terraform to communicate with remote systems. In this case, the aws provider connects to AWS and creates the resources on your behalf. The hashicorp/aws source indicates that you are using an official HashiCorp supported provider

```h
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.9.0"
    }
  }
}
```

Take note of the version, set to 5.9.0. Setting the provider version is important due to the frequent, potentially breaking, updates deployed for the AWS provider.

By setting this value, you can pin the specific functionality of that version, and avoid any updates negatively impacting your project. Without this version defined, Terraform will utilize the latest version of the AWS provider.

```h
provider "aws" {
  region = "us-west-2"
}
```

The provider resource block is used to specify how to authenticate to AWS and which region to connect to. This lab will authenticate and deploy resources into the us-west-2 region.

In this lab environment, the EC2 hosting this IDE environment has been granted permissions to the AWS environment and is passing the credentials through to the provider. Terraform is authenticated by accessing the IAM Role permissions granted to the EC2 instance profile.

```h
resource "aws_vpc" "lab_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "ca-lab-vpc"
  }
}
```

The aws_vpc resource is configured with a second lab_vpc label. This label is used to identify this specific VPC resource. These labels allow resources to be identified within the configuration file and are useful when more than one instance of a resource exists.

The cidr_block identifier is used to explicitly set the IPv4 CIDR block of the VPC.

Argument specifications for each resource block can be found in the Terraform documentation available for each provider. The CIDR block argument is an example of an optional VPC argument used to configure the resource.

Depending on the resource type, the AWS provider will create and apply changes to the resource using certain default values if a value is not present for the argument. You will see this in action later in this lab.

```h
output "id" {
  description = "VPC ID"
  value       = aws_vpc.lab_vpc.id
}
output "route_table_id" {
  description = "Route Table ID associated with this VPC"
  value       = aws_vpc.lab_vpc.main_route_table_id
}
output "security_group_id" {
  description = "Default Security Group ID"
  value       = aws_vpc.lab_vpc.default_security_group_id
}
```
Outputs are commonly used to pass values between Terraform modules. In this lab, you are introduced to outputs as a way of displaying specific VPC attributes upon deployment.

After a successful deployment, the id, route_table_id, and security_group_id attributes will display in the terminal. These values did not have to be explicitly defined and are an example of the automatic provisioning that takes place under the hood with the AWS provider.

To retrieve these attributes, a reference is made to the specific VPC resource defined earlier.

```bash
cd aws_vpc && terraform init
```
or
```bash
terraform init
```

With the VPC configuration complete, you can begin the deployment process.

The first step is to initialize Terraform. When you run terraform init, the specific version of the AWS provider is installed. Terraform will create a .terraform.lock.hcl file to record these provider settings.

```bash
terraform plan
```

The terraform plan command will provide you with any required changes that will be applied to your infrastructure. This command's output is a detailed preview of the deployment including resource configurations and template outputs.

For most of the VPC attributes, the known after apply placeholder will appear. When you run the plan command, Terraform will return as much information as it can predict about the deployment. These values are typically non-deterministic, such as IDs that are specific to the platform or randomly generated.

A Plan field will outline the number of resources to add, change, or destroy as a part of this deployment. You will only be adding 1 resource.

```bash
terraform apply --auto-approve
```

To execute the actions and configurations proposed in the Terraform plan, you must run the terraform apply command. When this command is run, the Terraform plan output will appear, followed by a confirmation prompt to allow the developer to accept or deny the changes.

In this case, you will run the apply command with the auto-approve flag to accept the changes automatically. This flag is commonly used in scripts that use Terraform to deploy infrastructure without the need for human intervention.


The apply command will succeed with a Apply complete! message followed by the VPC output values. This confirms the one Amazon VPC has been created.

You can also use the AWS CLI describe-vpcs command to confirm the deployment and display attributes that were unknown before the deployment.

To verify using the AWS CLI, click to run the following command:

```bash
aws ec2 describe-vpcs --filters Name=is-default,Values=false
```
