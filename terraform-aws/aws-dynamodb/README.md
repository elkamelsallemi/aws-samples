# AWS DynamoDB with terraform

## Introduction

For Terraform to understand the order in which resources are deployed, developers can define resources using implicit dependencies between resources.

Larger Terraform projects can include multiple dependencies, luckily illustration tools can be used to visualize a Terraform infrastructure.


### aws_dynamodb_table table

The aws_dynamodb_table table resource is configured with read an write capacity, as well as a defined hash_key attribute.

To add a DynamoDB item to this table, the item must access this table's name and hash_key attribute.

```h
resource "aws_dynamodb_table" "table" {
  name           = "example-name"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "exampleHashKey"
  attribute {
    name = "exampleHashKey"
    type = "S"
  }
}
```

The aws_dynamodb_table_item item resource references the table_name and hash_key attributes of the DynamoDB table above.

The configuration also provides an item object with attributes, which will be added to the table.


### DOT-formatted object
Enter the following command in the terminal window to generate a DOT-formatted object that represents your Terraform configuration:

```bash
terraform graph
```

Enter the following command into the terminal to apply the configuration and observe the output:

```bash
terraform apply --auto-approve
```

As expected, the Terraform apply command returns a ResourceNotFoundException: Requested resource not found error for the item resource.

The table resource will be created successfully, but since the table did not exist at the time of the initial item creation, the item will not be created.

This race condition can be remedied with the use of an implicit dependency.

