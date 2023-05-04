resource "digitalocean_droplet" "machinesonarqube" {
  name = "machinesonarqube"
  region = "fra1"
  size = "s-1vcpu-2gb"
  image = "ubuntu-20-04-x64"
  ssh_keys = ["keyexemple1", "keyexemple2", "keyexemple3", "keyexemple4"]

  
   provisioner "remote-exec" {
    inline = ["sudo ufw disable"]
     connection {
       type        = "ssh"
       user        = "root"
       host        = digitalocean_droplet.machinesonarqube.ipv4_address
     }
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.ipv4_address},' prerequis.yaml"
  }
 }
