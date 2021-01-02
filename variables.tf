variable "creds_path" {
    default = "../credentials.json"
} 

variable "project" {
    default = "dark-depth-298212"
} 

variable "region" {
    default = "asia-southeast1"
} 

variable "zone" {
    default = "asia-southeast1-a"
} 


variable "image" {
    default = "ubuntu-os-cloud/ubuntu-1804-lts"
} 

variable "size" {
    default = "f1-micro"
} 

variable "net" {
    default = "default"
} 

variable "init" {
    default = "sudo apt-get update; sudo apt-get install -y tshark"
}