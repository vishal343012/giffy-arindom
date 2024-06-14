provider "google-beta" {
  credentials = file("/Users/arindoms/.ssh/giffy-repo-30481f1b5438.json")
  project     = var.project
  region      = var.region
  zone        = var.zone
}


# Defining google/kubernetest providers

terraform {
  required_providers {
    google-beta = {
      source = "hashicorp/google-beta"
      version = "5.30.0"
    }
  }
}

resource "google_compute_instance" "jenkins-20240527-170439" {
  project     = var.project
  # region      = var.region
  zone        = var.zone

  boot_disk {
    auto_delete = true
    device_name = "jenkins-20240527-170439"

    initialize_params {
      image = "projects/cos-cloud/global/images/cos-stable-113-18244-85-14"
      size  = 10
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    container-vm = "cos-stable-113-18244-85-14"
    goog-ec-src  = "vm_add-tf"
  }

  machine_type = "n2-standard-2"

  metadata = {
    gce-container-declaration = "spec:\n  containers:\n  - name: instance-20240527-170439\n    image: asia-south1-docker.pkg.dev/giffy-repo/infiflex-registry/jenkins:j2.0.7\n    securityContext:\n      privileged: true\n    stdin: false\n    tty: false\n  restartPolicy: Always\n# This container declaration format is not public API and may change without notice. Please\n# use gcloud command-line tool or Google Cloud Console to run Containers on Google Compute Engine."
    google-logging-enabled    = "true"

  }

  metadata_startup_script = "iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080"


  name = "jenkins-20240527-170439"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    queue_count = 0
    stack_type  = "IPV4_ONLY"
    subnetwork  = "projects/giffy-repo/regions/asia-south1/subnetworks/default"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = "1026525110346-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  tags = ["http-server", "https-server"]
}