# Install R and RStudio Server on Linux
This is a simple Ansible Playbook to install and configure R and RStudio server on any Linux machine or VM. To install on a Virtual Machine on CLAAUDIA see [this guide](https://www.strato-docs.claaudia.aau.dk/guides/quick-start/) to first create one. Then login through SSH and do the following:

 - Clone this git repository somewhere with `git clone https://github.com/cmc-aau/rstudio_server_setup.git && cd rstudio_server_setup`
 - Install ansible with: `pip3 install ansible` or `sudo apt-get install ansible ansible-galaxy` (If `pip3` is not installed run `sudo apt install python3-pip` first)
 - Install the required Ansible roles with `ansible-galaxy install -r roles/requirements.yml`
 - Adjust variables as you wish in `playbook.yml`, especially choose appropriate username(s) with the `rstudio_users` variable
 - Run the playbook with `ansible-playbook playbook.yml --connection=local`
 - When it's finished access RStudio Server through the browser at `http://ipaddress:8787`

To be able to login first create a password for each user listed under the `rstudio_users` variable using `sudo passwd username`.
