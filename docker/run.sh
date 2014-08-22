IP=$(docker inspect $(docker ps -a | awk /redis-server/'{print $1}') | awk -F \" /IPAddress/'{print $4}')
sed -e "s/127.0.0.1/"$IP"/" redis.php.template > redis.php
docker build -t centos:ap .
docker run -d -p 10022:22 -p 80:80 centos:ap
