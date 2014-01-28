#!/bin/bash

VAGRANT_CORE_FOLDER=$(echo "$1")

OS=$(/bin/bash "${VAGRANT_CORE_FOLDER}/shell/os-detect.sh" ID)
CODENAME=$(/bin/bash "${VAGRANT_CORE_FOLDER}/shell/os-detect.sh" CODENAME)

if [[ ! -d /.provision-stuff ]]; then
    mkdir /.provision-stuff

    echo "${VAGRANT_CORE_FOLDER}" > "/.provision-stuff/vagrant-core-folder.txt"
    echo "Created directory /.provision-stuff"
fi

if [[ ! -f /.provision-stuff/initial-setup-repo-update ]]; then
    if [ "${OS}" == 'debian' ] || [ "${OS}" == 'ubuntu' ]; then
        echo "Running initial-setup apt-get update"
        apt-get update >/dev/null
        touch /.provision-stuff/initial-setup-repo-update
        echo "Finished running initial-setup apt-get update"
    elif [[ "${OS}" == 'centos' ]]; then
        echo "Running initial-setup yum update"
        yum update -y >/dev/null
        echo "Finished running initial-setup yum update"

        echo "Installing basic development tools (CentOS)"
        yum -y groupinstall "Development Tools" >/dev/null
        echo "Finished installing basic development tools (CentOS)"
        touch /.provision-stuff/initial-setup-repo-update
    fi
fi

if [[ "${OS}" == 'ubuntu' && ("${CODENAME}" == 'lucid' || "${CODENAME}" == 'precise') && ! -f /.provision-stuff/ubuntu-required-libraries ]]; then
    echo 'Installing basic curl packages (Ubuntu only)'
    apt-get install -y libcurl3 libcurl4-gnutls-dev >/dev/null
    echo 'Finished installing basic curl packages (Ubuntu only)'

    touch /.provision-stuff/ubuntu-required-libraries
fi
