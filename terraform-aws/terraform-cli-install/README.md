# Terraform CLI

## Installing Terraform on Linux AWS EC2

Connect to EC2 instance and install Terraform on a Linux Server
1. Change directory to home:

```bash
cd ~/
```
2. Use wget to download the Terraform zip file:

```bash
wget https://releases.hashicorp.com/terraform/0.13.4/terraform_0.13.4_linux_amd64.zip
```
3. Unzip the zip file using the unzip command:

```bash
unzip terraform_0.13.4_linux_amd64.zip
```
4. Move the terraform binary to the /usr/local/bin directory:

```bash
sudo mv terraform /usr/local/bin
```
5. Verify that Terraform is installed:

```bash
terraform version
```
## Installing Terraform on Windows AWS EC2

1. new directory for Terraform on the Windows Server :

```bash
mkdir C:\terraform
cd C:\terraform
```
The Terraform binary will be saved to this folder and live there while Terraform is being used on the server.

2. Download the Terraform binary using Invoke-WebRequest:

```bash
Invoke-WebRequest -Uri https://releases.hashicorp.com/terraform/0.13.4/terraform_0.13.4_windows_amd64.zip -outfile terraform_0.13.4_windows_amd64.zip
```

3. Use Expand-Archive to extract the binary from the zip file and remove the zip file from the directory:

```bash
Expand-Archive -Path .\terraform_0.13.4_windows_amd64.zip -DestinationPath .\
rm .\terraform_0.13.4_windows_amd64.zip -Force
```

4. Set the Terraform directory as a PATH variable:

```bash
setx PATH "$env:path;C:\terraform" -m
```

5. Update the current PowerShell session with the new environment variable:

```bash
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
```

6. Confirm Terraform is installed:

```bash
terraform version
```