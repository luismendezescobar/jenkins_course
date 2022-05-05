/************************************************************************************************************************************************************
# Variables
************************************************************************************************************************************************************/
#################################################################################################### 
#  
#
####################################################################################################


environment = "dev"
gcp_vpc_name = "default"
gcp_subnet_1 = "us-central1"
gcp_region = "us-central1"
gcp_project_id = "playground-s-11-906adac1"
client = "ideasextraordinarias"
gcp_vpc_cidr = "10.128.0.0/20"
gcp_zone = "us-central1"
zones = ["us-central1-a","us-central1-b","us-central1-c"]


# vm - BASTION ---------------------------
cidr_blocks = "0.0.0.0/0"
machine_type = "f1.micro" 
#metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 -y && echo '<!doctype html><html><body><h1>Hello from Terraform on Google Cloud!</h1></body></html>' | sudo tee /var/www/html/index.html"
metadata_startup_script = "scripts/bootstrap.sh"