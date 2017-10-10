#!/bin/bash

name="blog"

cd website
for x in {1..3}; do
   echo "Removing ${name}-nginx-${x} container and image"
   docker rm ${name}-nginx-${x} --force
   docker rmi ${name}-nginx-${x}
done

cd  ../haproxy
echo "Removing ${name}-lb cotainer and image"
docker rm ${name}-lb --force
docker rmi ${name}-lb
cd ..
