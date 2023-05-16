docker container rm "$(docker container ps -a -q)"
docker rmi "$(docker image ls -a -q)" --force
docker rmi "$(docker image ls -a -q)" --force
docker volume rm "$(docker volume ls -q)"
docker system prune --force
