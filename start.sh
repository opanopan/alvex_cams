#!/bin/bash

# Установи docker и запусти этот скриптик
# http://example.com - страница сервера
# http://example.com/cam1_80 
# http://example.com/cam1_8080
# http://example.com/cam2_80
# http://example.com/cam2_8080

docker pull olepan/alvex_camera1
docker pull olepan/alvex_camera2
docker pull olepan/alvex_proxy

docker network create alvex

docker run -d --net alvex -P --name cam1 olepan/alvex_camera1
docker run -d --net alvex -P --name cam2 olepan/alvex_camera2
docker run -d --net alvex -P --name proxy olepan/alvex_proxy

echo "0.0.0.0 example.com" >> /etc/hosts
