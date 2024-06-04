#!/bin/bash
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