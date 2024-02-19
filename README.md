# Terraform

### Introduction
Terraform configuration files are written in the HashiCorp Configuration Language (HCL), which is designed to be both human-readable and machine-friendly. HCL allows you to treat your infrastructure as code and serves as your system's "living documentation". The Terraform files you will work with to manage your infrastructure use the .tf file extension.

The following code illustrates the block-style syntax used to describe your infrastructure:

```h
TYPE "LABEL" "LABEL" {
  <IDENTIFIER> = <EXPRESSION>
}
```

This is an example of a block, which is a container for other content in your configuration file.

Each block has a TYPE, which will determine how many labels must follow the type keyword. A LABEL can specify a variant of the block type being used, or be used to define a name tag for that specific block.

A block contains a body, which is delimited by the opened and closed curly braces { }. Within the body, you will declare arguments associated with the block. These arguments appear in the form of key-value pairs commonly referred to as IDENTIFIERS and EXPRESSIONS.

### DOT-formatted object
Enter the following command in the terminal window to generate a DOT-formatted object that represents your Terraform configuration:

```bash
terraform graph
```