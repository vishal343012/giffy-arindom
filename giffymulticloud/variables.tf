variable "project" {
    type = string
}

variable "zone" {
    type = string
}

variable "region" {
    type = string
}

variable "registry" {
    type = string
}

variable "username" {
    type = string
}

variable "password" {
    type = string
}

variable "image" {
    type = string
}

variable "jenkins_instance_network" {
  description = "The GCP network to deploy the Jenkins VM in. The firewall rules will be created in the project which hosts this network."
}

variable "jenkins_instance_subnetwork" {
  description = "The GCP subnetwork to deploy the Jenkins VM in"
}

variable "service_account" {
  description = "The project ID of the Jenkins network"
  default     = "1026525110346-compute@developer.gserviceaccount.com"
}

variable "jenkins_instance_access_cidrs" {
  type        = list(string)
  description = "CIDRs to allow to access Jenkins over HTTP(s)"
  default     = ["0.0.0.0/0"]
}

variable "jenkins_instance_zone" {
  description = "The zone to deploy the Jenkins VM in"
}

variable "public_key" {
    description = "Public key"
}
