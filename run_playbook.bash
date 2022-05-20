#!/usr/bin/env bash
set -eu
ansible_venv=${ansible_venv:-"ansible-venv"}
playbook_file=${playbook_file:-"playbook.yml"}
requirements_file=${requirements_file:-"roles/requirements.yml"}

message() {
    echo " *** $1..."
}

setup_ansible_venv() {
    message "Checking whether virtual environment already exists at ${ansible_venv}"
    if [ ! -s "${ansible_venv}/bin/activate" ]
    then
        message "Checking for required system packages"
        pkgs="software-properties-common python3-venv"
        if ! dpkg -s $pkgs >/dev/null 2>&1
        then
            message "One or more required system packages are not installed, installing"
            sudo apt-get update -qqy
            sudo apt-get install -y $pkgs
        else
            message "All required system packages are already installed"
        fi
        message "Installing ansible into virtual environment: ${ansible_venv}"
        python3 -m venv "$ansible_venv"
        . "${ansible_venv}/bin/activate"
        #wheel must be installed first, can't be done in the same command
        python3 -m pip install wheel
        python3 -m pip install ansible
        deactivate
    else
        message "Virtual environment already exists"
    fi
}

run_playbook() {
    if [ -s "$requirements_file" ]
    then
        message "Ensuring required Ansible roles are installed (from ${requirements_file})"
        #ansible-galaxy collection install community.general --roles roles
        ansible-galaxy install -r roles/requirements.yml --roles roles/
    fi
    message "Running Ansible playbook \"${playbook_file}\" from virtual environment"
    . "${ansible_venv}/bin/activate"
    ansible-playbook "${playbook_file}" "$@"
    deactivate
}

setup_ansible_venv
run_playbook "$@"
