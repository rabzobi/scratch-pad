# scratch-pad

These scripts work for me but will NOT work for you.
Please read all of them before running them and adjust paths to yours.
You WILL need to change them!

One day (when I have time) I will make them more generic.

chsh -s /bin/bash

Rename: DOT-bash_profile to ~/.bash_profile



Get your db up

opennms-dokcker/openms-db.yml

docker-compose -f file.yml up -d

 ~/scratch-pad/scripts/opennms-setup.sh

To get inside container:

docker exec -it postgres_container bash

psql



Opennms mail needs you to start postfix (which should be installed by default)

rellis@BFSMRELLIS:~$ sudo postfix start

postfix/postfix-script: starting the Postfix mail system

else you can configure it to point elsewhere
