Install Ubuntu 2022 Minimal (I use Ventoy)

```
sudo apt-get install git
git clone git@github.com:OpenNMS-Cloud/portal-backend.git
```
Install maven
```
sudo apt install maven
```
Intall Azure CLI
```
sudo curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```


Building
```
cd portal-backend/portal-mp
./gradlew build publishJvmPublicationToMavenLocal
```

Azure Login, should open browser
```
az login
```

Fetch settings

Change into the folder portal-functionapp, internal-functionapp, or external-functionapp:

```
cd portal-functionapp
func azure functionapp fetch-app-settings {functionAppName}

```

At the time of this writing functionAppName can be one of the following (assuming the dev instance): onms-portal-dev, onms-internal-dev, or onms-external-dev


Install docker from docker io (I forgot how)
pip3 install --upgrade --force-reinstall --no-cache-dir docker-compose && ln -sf /usr/local/bin/docker-compose /usr/bin/docker-compose

Install local postgres
~~~
cd ~/scratch-pad/postgres-docker/
sudo docker-compose -f opennms-db.yml up -d
~~~

Scripts that might help you
https://github.com/rabzobi/scratch-pad

