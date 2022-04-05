// Configure the Google Cloud provider
provider "google" {
 credentials = "${file("${var.credentials}")}"
 project     = "${var.gcp_project}"
 region      = "${var.region}"
 zone        = "${var.zone}"
}
resource "google_compute_network" "vpc_network" {
name = "${var.vpc-name}"
}
resource "google_compute_subnetwork" "public-subnetwork" {
name = "${var.subnet-name}"
ip_cidr_range = "${var.ip_cidr_range}"
region = "${var.region}"
network = google_compute_network.vpc_network.name
}
// VPC firewall configuration
resource "google_compute_firewall" "demo-firewall" {
  name    = "${var.firewall-name}"
  network = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "8080", "1000-2000"]
    
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "vm-instance" {
  name         = "${var.instance_name}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }


  network_interface {
    network = "${var.network}"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

 
}
