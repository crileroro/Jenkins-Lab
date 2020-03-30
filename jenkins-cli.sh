#! /bin/bash
#***************************
# USEFUL INFORMATION
# Be sure to have completed the following steps before using this script:
#  1. Download the plugin SSH.
#  2. Configure the port 53801 (published by the Docker compose file) in 
#     Manage Jenkins -> Configure Global Security ->SSH Server Fixed: 53801
#  3. Paste the public ssh key of the machine you are intended to connect from in
#     SSH public key of your jenkins user. Go to your user and:
#     Configure -> SSH Public Keys.
#  4 Use the following base command followed by the jenkins command you want to run:
#       java -jar jenkins-cli.jar -s http://localhost:8080 -ssh -user <USER> <JENKINS-COMMAND>
#***************************

jc="java -jar jenkins-cli.jar -s http://localhost:8080 -ssh -user admin"

$jc list-jobs > jobs.txt
JOBS=$(wc -l jobs.txt | awk '{print $1}')

for i in `seq 1 $JOBS`
do
    JOB_NAME="$(sed "$i!d" jobs.txt)"
    FILENAME=$JOB_NAME.xml
    $jc get-job "$JOB_NAME" > "$FILENAME"
done

# Run the seed job
$jc build seed -f -v