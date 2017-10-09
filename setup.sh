#!/bin/bash

name="blog"

#Config cleanup
sed -i '/^server/d' haproxy/haproxy.cfg

#Settin up website
cd website
for x in {1..3}; do
   cat conf/default.conf |sed "s/XXXX/8${x}/" > default.conf
   echo ""
   docker build -t ${name}-nginx-${x} .
   [  "$(docker ps -a | grep ${name}-nginx-${x})" ] && docker rm ${name}-nginx-${x} --force
   docker run -p 8${x}:8${x} --name ${name}-nginx-${x} -d ${name}-nginx-${x} && echo "*** Running instance of ${name}-nginx-${x} on http://localhost:8${x} ***"
   echo "server s1 `docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' blog-nginx-${x}`:8${x} maxconn 32" >> ../haproxy/haproxy.cfg
   echo ""
done

#Setting up ha-proxy
cd  ../haproxy
echo ""
docker build -t ${name}-lb .
[  "$(docker ps -a | grep ${name}-lb)" ] && docker rm ${name}-lb --force
docker run -p 8020:8020 -d --name ${name}-lb ${name}-lb

echo "*** Please go to http://localhost:8020 ***"
