# Install R and RStudio Server on Linux
This is a simple Ansible Playbook to install and configure R and RStudio server on any Linux machine or VM. To install on a Virtual Machine on CLAAUDIA see [this guide](https://www.strato-docs.claaudia.aau.dk/guides/quick-start/) to first create one. Then login through SSH and do the following:

 - Clone this git repository somewhere with `git clone https://github.com/cmc-aau/rstudio_server_setup.git && cd rstudio_server_setup`
 - Adjust variables as you wish in `playbook.yml`, but especially choose appropriate username(s) with the `rstudio_users` variable. If you only want to use the current user, set it to that to assure that it will be added to the `rstudio_users_group` group that grants access to RStudio Server
 - Run the Ansible playbook with `bash run_playbook.bash playbook.yml --connection=local`
 - Once it's finished access RStudio Server through the browser at `http://ipaddress:8787`

To be able to login first create a password for each user listed under the `rstudio_users` variable, using fx `sudo passwd username`. This folder is not needed anymore, you can safely delete it. Also ensure port 8787 (ingress) is open or you wont be able to connect. (With openstack go to Network -> Security Groups -> Manage Rules -> Add rule).
