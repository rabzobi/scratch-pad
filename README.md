# scratch-pad

These scripts work for me but will probably NOT work for you out of the box
Please read all of them before running them and adjust paths to yours.

# Bash
```
chsh -s /bin/bash
ln -s ~/scratch-pad/DOT-bash_profile ~/.bash_profile
```
# DB
```
docker-compose -f opennms-db.yml up -d
~/scratch-pad/scripts/opennms-setup.sh
To get inside container:
docker exec -it postgres_container bash
```
# Postfix
Opennms mail needs you to start postfix (which should be installed by default)

> rellis@BFSMRELLIS:~$ sudo postfix start
