![N|Docker](https://dt-cdn.net/assets/images/content/resources/docker-c-0e3b80d791.png)

## Intro
This is a quick poc for hosting a static website inside a Docker continer which is run locally.
There is also an load balancer (haproxy) in front of web server which can be replaced with any
load balancing solution in the production environment. Thanks to LB we should be able to deploy
multiple servers if our page will become more poppular by scaling horizontally where a cluster
of load balancers could loadbalance a number of web servers behind. Please remember this is only
POC

### Prerequisites:
- docker

## How to install:

### Manually:
- Build the image with the content by running command:
```sh
  $ docker build -t simple-nginx .
```
- Run the container with command:
```sh
  $ docker run -p 80:80 --name blog-nginx -d simple-nginx
```
- Confirm container is running:
```sh
  $ docker ps
	CONTAINER ID        IMAGE                 COMMAND                  CREATED             STATUS              PORTS                                                       NAMES
	543cf69a2008        simple-nginx          "nginx -g 'daemon ..."   5 seconds ago       Up 2 seconds        0.0.0.0:80->80/tcp                                          blog-nginx
```


### Automatically:

To create number of backend instances use setup script
- Run ./setup.sh

### How to access website
  - Direct access  on local resource http://localhost/
  - Via LB http://localhost:8020/

## Cleanup
 When done with testing, you can remove containers and images by running cleanup script
```sh
./cleanup.sh
```
