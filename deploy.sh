docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker rmi $(docker images -aq)
docker pull vivekjag1/softengproduction
docker run -d -p 80:80 vivekjag1/softengproduction