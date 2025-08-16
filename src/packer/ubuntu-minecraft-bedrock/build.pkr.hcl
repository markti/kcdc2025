
build {
  sources = [
    "source.azure-arm.vm"
  ]

  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "apt-get update",
      "apt-get clean"
    ]
  }

  # install Azure CLI
  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "curl -sL https://aka.ms/InstallAzureCLIDeb | bash"
    ]
  }

  # We use CURL to grab the server download page from Minecraft.net. With this page, we can scan it and make sure we are grabbing the latest download link.
  # This saves time by ensuring the latest version is always downloaded.
  provisioner "shell" {
    execute_command = local.execute_command
    inline          = ["apt-get -y install curl"]
  }

  # The wget package is what we will use to download the Minecraft Bedrock server to Ubuntu.
  provisioner "shell" {
    execute_command = local.execute_command
    inline          = ["apt-get -y install wget"]
  }

  # This package is the simplest package we are installing and is what we need to extract the server from the downloaded archive.
  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "apt-get update",
      "apt-get -y install unzip"
    ]
  }

  # We use the grep package to extract the correct download link from the page we grabbed using curl.
  provisioner "shell" {
    execute_command = local.execute_command
    inline          = ["apt-get -y install grep"]
  }

  # Screen will make accessing the servers command line easier remotely when we run the server as a service.
  # This package allows us to create a detached screen where the Bedrock server will run.
  provisioner "shell" {
    execute_command = local.execute_command
    inline          = ["apt-get -y install screen"]
  }

  # The Minecraft Bedrock server requires the OpenSSL library to run.
  provisioner "shell" {
    execute_command = local.execute_command
    inline          = ["apt-get -y install openssl"]
  }

  # required by Minecraft Bedrock
  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb -O libssl1.1.deb",
      "dpkg -i libssl1.1.deb",
      "rm libssl1.1.deb"
    ]
  }

  # The jq package is what we will use to parse JSON data in our scripts.
  provisioner "shell" {
    execute_command = local.execute_command
    inline          = ["apt-get -y install jq"]
  }

  # Setup Minecraft User Account
  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "useradd -m ${local.service_username}",
      "usermod -a -G ${local.service_username} $USER",
      "mkdir -p ${local.server_folder_path}"
    ]
  }

  # Download Minecraft Bedrock server
  provisioner "shell" {
    execute_command  = local.execute_command
    script           = "./scripts/download_minecraft.sh"
    environment_vars = ["WORKDIR=${local.server_folder_path}"]
  }

  # Install Minecraft
  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "unzip ${local.server_folder_path}/bedrock-server.zip -d ${local.server_folder_path}/",
      "rm ${local.server_folder_path}/bedrock-server.zip",
      "chown -R ${local.service_username}: /home/${local.service_username}/"
    ]
  }

  # Minecraft start_server.sh
  provisioner "file" {
    source      = "./files/start_server.sh"
    destination = "/tmp/start_server.sh"
  }
  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "cp /tmp/start_server.sh ${local.server_folder_path}/",
      "chmod +x ${local.server_folder_path}/start_server.sh"
    ]
  }

  # Minecraft stop_server.sh
  provisioner "file" {
    source      = "./files/stop_server.sh"
    destination = "/tmp/stop_server.sh"
  }
  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "cp /tmp/stop_server.sh ${local.server_folder_path}/",
      "chmod +x ${local.server_folder_path}/stop_server.sh"
    ]
  }

  # Minecraft ops_backup_server.sh
  provisioner "file" {
    source      = "./files/ops_backup_server.sh"
    destination = "/tmp/ops_backup_server.sh"
  }
  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "cp /tmp/ops_backup_server.sh ${local.server_folder_path}/",
      "chmod +x ${local.server_folder_path}/ops_backup_server.sh"
    ]
  }

  # Minecraft ops_restore_server.sh
  provisioner "file" {
    source      = "./files/ops_restore_server.sh"
    destination = "/tmp/ops_restore_server.sh"
  }
  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "cp /tmp/ops_restore_server.sh ${local.server_folder_path}/",
      "chmod +x ${local.server_folder_path}/ops_restore_server.sh"
    ]
  }

  # Minecraft ops_upgrade_server.sh
  provisioner "file" {
    source      = "./files/ops_upgrade_server.sh"
    destination = "/tmp/ops_upgrade_server.sh"
  }
  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "cp /tmp/ops_upgrade_server.sh ${local.server_folder_path}/",
      "chmod +x ${local.server_folder_path}/ops_upgrade_server.sh"
    ]
  }

  # Minecraft systemctl service
  provisioner "file" {
    source      = "./files/${local.service_name}.service"
    destination = "/tmp/${local.service_name}.service"
  }
  provisioner "shell" {
    execute_command = local.execute_command
    inline          = ["cp /tmp/${local.service_name}.service /etc/systemd/system/"]
  }

  provisioner "shell" {
    execute_command = local.execute_command
    inline          = ["chown -R ${local.service_username}: /home/${local.service_username}/"]
  }


  provisioner "shell" {
    execute_command = local.execute_command
    inline          = ["/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"]
    only            = ["azure-arm"]
  }

}