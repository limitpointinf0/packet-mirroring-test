// Configure the Google Cloud provider
provider "google" {
    credentials = file(var.creds_path)
    project     = var.project
    region      = var.region
}

resource "random_id" "instance_id" {
    byte_length = 8
}

// Recipient
resource "google_compute_instance" "recipient" {
    name         = "recipient-vm-${random_id.instance_id.hex}"
    machine_type = var.size
    zone         = var.zone

    boot_disk {
        initialize_params {
            image = var.image
        }
    }

    metadata_startup_script = var.init

    network_interface {
        network = var.net
    }
}

// Sender
resource "google_compute_instance" "sender" {
    name         = "sender-vm-${random_id.instance_id.hex}"
    machine_type = var.size
    zone         = var.zone

    boot_disk {
        initialize_params {
            image = var.image
        }
    }

    metadata = {
        ssh-keys = "chris:${file("~/.ssh/id_rsa.pub")}"
    }

    metadata_startup_script = var.init

    network_interface {
        network = var.net

        // has an external ip
        access_config {}
    }
}

// Wildcard
resource "google_compute_instance" "wild" {
    name         = "wildcard-vm-${random_id.instance_id.hex}"
    machine_type = var.size
    zone         = var.zone

    boot_disk {
        initialize_params {
            image = var.image
        }
    }

    metadata = {
        ssh-keys = "chris:${file("~/.ssh/id_rsa.pub")}"
    }

    metadata_startup_script = var.init

    network_interface {
        network = var.net

        // has an external ip
        access_config {}
    }
}

resource "google_compute_instance_group" "packet-mirrors" {
    name        = "terraform-packet-mirrors"
    description = "Terraform test packet mirroring"

    instances = [
        google_compute_instance.recipient.id,
    ]

    zone = var.zone
}

output "sender-ip" {
    value = google_compute_instance.sender.network_interface.0.access_config.0.nat_ip
}

output "wild-ip" {
    value = google_compute_instance.wild.network_interface.0.access_config.0.nat_ip
}