terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.8.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

# DynamoDB Table

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

# DynamoDB Table Item

resource "aws_dynamodb_table_item" "item" {
  table_name = "example-name"
  hash_key   = "exampleHashKey"
  item = <<ITEM
{
  "exampleHashKey": {"S": "something"},
  "one": {"N": "11111"},
  "two": {"N": "22222"},
  "three": {"N": "33333"},
  "four": {"N": "44444"}
}
ITEM
}