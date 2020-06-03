# TKGI-Backup
scripts to deploy BBR and Velero to TKGI demo

Bosh Backup and restore (BBR) applied to TKGI : https://docs.pivotal.io/pks/1-7/backup-and-restore.html

This repository includes scripts to facilitate the setup and use of BBR in TKGI.

The scripts are meant to be run from a linux jumpbox that has network access to the TKGI environment.

Steps : 
1) edit file "env-epmc" to set values for your environment
2) use scripts from 1-9 to setup pre-reqs
3) use script 10 + for BBR setup and use

FYI : these scripts have been tested in lab with TKGI + NSX-T using builtin UAA database.






To Do : 
    - BBR : add script to automatically list all K8S deployments and generate backup for them
    - BBR : test/addapt for LDAP integrated environment
    - Velero : 