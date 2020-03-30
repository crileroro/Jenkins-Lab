# Jenkins-Lab
This project describes some functionalitites included in Jenkins, how to set them up and their use. These functionalities are listed below:
  * Execute Scripts on remote host using SSH.
  * Jenkins DSL (Domain Specifis Language).
  * Jenkinsfile.
  * Creation of slave nodes using Docker containers.

## Getting started
These instructions will get you through the steps to run locally your Jenkins instance using Docker containers.

### Prerequisites
  * Docker CE.
  * Docher compose.

### Installing
#### Run Jenkins master
To persist Jenkins configuration, the first thing you need to do is to change the ownership of the directory [jenkins-home](jenkins-server/jenkins-home) located in the folder `jenkins-server` of this repo. Docker image from Jenkins runs using the user `jenkins` (UID 1000):
```sh
chown -R 1000:1000 <path_to_repository>/jenkins-server/jenkins-home
```
Run the script `start-services.sh`. This script initiates Compose file located in the root of this repo, creating two containers: Jenkins master and a remote host. First one will expose two ports: 
* 8080 to access UI.
* 53801 to access Jenkins via the Jenkins CLI.

You will see these two services by running the command `docker-compose ps`.
Access Jenkins UI on http://localhost:8080.

### Jenkins DSL
Jenkins jobs can be created programmatically using Jenkins DSL.
3 simple jobs for this lab can be found at [this link](https://github.com/crileroro/jenkins-job-dsl).

#### Run Jenkins DSL
##### Required Plugins or Others
- *Job DSL* plugin.
##### Set Up 
Install the required Jenkins plugin and follow the steps listed in the setup section of the repo described above.

#### Run scripts in a remote host using SSH
##### Required Plugins or Others
- *SSH* plugin
##### Set Up
After downloading the required plugin, go to *Manage Jenkins -> Configure System*. In the section *SSH remote hosts*, add a new SSH site with the following information:

- **Hostname**: *remote_host* (This corresponds to the service name of the remote host in the `docker-compose` file).
- **Port**: *22*
- **Credentials**: Create a *SSH Username with Private Key* type credentials. Use as Private key the one you will find in the .ssh folder of the Jenkions master [here](jenkins-server/jenkins-home).

Use the `remote-connection-dsl` job created through Jenkins DSL to run a simple command in the remote host.

#### Jenkins CLI
##### Required Plugins or Others
- *jenkins-cli.jar* (go to *Manage Jenkins -> Jenkins CLI* and click on the file name to download it).
##### Set Up
Put the file in the root of this repo and run the script `jenkins-cli.sh`. This example script describes how to use *Jenkins CLI* running the following scenarios:
1. List the current jobs. This list will be saved in a file named *job.txt*.

2. Extract their config.xml file. They will be created in the root of this repo.

3. Run the seed job (Jenkins DSL).

### Use of Docker nodes to run Jenkins Jobs
##### Required Plugins or Others
- *Docker plugin*
- Docker host (a Debian VM in VirtualBox is used for this lab). This host will need to have installed *Docker CE*.

##### Set Up
*Docker plugin*

Once you have installed the plugin, go to *Manage Jenkins -> Manage nodes and clouds*. Go to *Configure Clouds* and add a new Docker cloud. In here, fill it in with the following information:
- *Docker Host URI*: tcp://<Docker_host_IP_address>:4243.

After that, add a new *Docker Agent Template*. This template will create a new container based in the image you add in the *Docker Image* field which will build your app. This image should include at least the following configuration (You can take a look at [this Dockerfile](docker-slave/Dockerfile)):

- sshd service running on port 22.
- Jenkins user with password (This will be necessary in the field *Connect method -> Connect with SSH* of the cloud configuration).
- Required application dependencies for the build.


*VM set up*

In case you may want to create a Debian VM, run the script [configure-debian-slave.sh](configure-debian-slave.sh) to set up a simple Docker host. This script will run the following configuration:

- Install Docker CE.
- Install Docker Compose.
- Enable Docker remote API: The Docker daemon can listen for Docker Engine API requests via 3 different types of socket: **unix**, **tcp** and **fd**. By default, **unix** socket is enabled (*/var/run/docker.sock*). Due to the fact that unix socket works for exchanging data between processes executing on the same host OS, this does not help if you want to access the Docker Rest API remotely. This is why it is necessary to enable TCP socket (*/lib/systemd/system/docker.service*). 

If you are creating your Docker host using a VM in VirtualBox/VMware, attach it to a Bridged Adapter. This option will allow you to have more interaction between your host and guest machine (your VM will have its own IP address, in the same network range of your host machine). It becomes handy as Jenkins will spin up a new container on a random port and you VM should be able to be contactable on that specific port. (The use of the networking mode NAT is cumbersome as you should port forward a range of ports to your VM.)


### Jenkinsfiles


