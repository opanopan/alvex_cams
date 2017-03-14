#!/bin/bash

# Установи docker, запусти службу и запусти этот скриптик.
# В браузере будет:
# http://example.com - страница сервера
# http://example.com/cam1_80 
# http://example.com/cam1_8080
# http://example.com/cam2_80
# http://example.com/cam2_8080
#
# Конфиг nginx на сервере можно посмотреть командой:
# docker exec proxy cat /etc/nginx/nginx.conf

docker pull olepan/alvex_camera1
docker pull olepan/alvex_camera2
docker pull olepan/alvex_proxy

docker network create alvex

docker run -d --net alvex -P --name cam1 olepan/alvex_camera1
docker run -d --net alvex -P --name cam2 olepan/alvex_camera2
docker run -d --net alvex -P --name proxy olepan/alvex_proxy

ip=`docker inspect -f '{{ .NetworkSettings.Networks.alvex.IPAddress }}' proxy`
echo "$ip example.com" >> /etc/hosts
