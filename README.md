# scratch-pad

Some scripts I used for building and running parts of open nms
Please read them before running them and adjust to your needs

# Bash
```
chsh -s /bin/bash
ln -s ~/scratch-pad/DOT-bash_profile ~/.bash_profile
```
# DB
```
sudo docker-compose -f opennms-db.yml up -d
~/scratch-pad/scripts/opennms-setup.sh
To get inside container:
docker exec -it postgres_container bash

NOTE when you are setting up a connection for pg_admin to localhost use the container name and NOT localhost
```
# Postfix
Opennms mail needs you to start postfix (which should be installed by default)

> rellis@BFSMRELLIS:~$ sudo postfix start


