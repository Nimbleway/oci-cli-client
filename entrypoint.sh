#!/bin/bash

if ! command -v python &> /dev/null
then
    echo "python not found, installing..."
    # Install OCI CLI
    sudo rm -f /etc/apt/sources.list.d/docker.list /etc/apt/sources.list.d/kubernetes.list
    sudo add-apt-repository ppa:deadsnakes/ppa -y
    sudo apt-get update
    sudo apt install software-properties-common -y
    sudo apt-get install python3 python3-pip jq -y
    #sudo python3 -m pip install --upgrade pip
    python3 --version
    pip3 --version
else
    echo "python is already installed"
fi

if ! command -v oci &> /dev/null
then
    echo "OCI CLI not found, installing..."
    # Install OCI CLI

    wget https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh
    sudo bash install.sh --accept-all-defaults --exec-dir /usr/local/bin
    mkdir -p ~/.oci
    echo [DEFAULT] >> ~/.oci/config
    echo user="$OCI_CLI_USER" >> ~/.oci/config
    echo fingerprint="$OCI_CLI_FINGERPRINT" >> ~/.oci/config
    echo key_file=~/.oci/oci_api_key.pem >> ~/.oci/config
    echo tenancy="$OCI_CLI_TENANCY" >> ~/.oci/config
    echo region="$OCI_CLI_REGION" >> ~/.oci/config
    echo "$OCI_CLI_KEY_CONTENT" >> ~/.oci/oci_api_key.pem
    oci setup repair-file-permissions --file ~/.oci/config
    oci setup repair-file-permissions --file ~/.oci/oci_api_key.pem    

else
    echo "OCI CLI is already installed"
fi