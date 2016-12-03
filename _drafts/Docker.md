# Docker

## Docker Ürünleri

* Docker Machine
* Docker Registery
* Docker Compose
* Docker Swarm
* Docker Datacenter
* Docker Cloud

## Docker-machine

Sanallaştırma aracı

Komut: `docker-machine`

docker-machine create --driver virtualbox --virtualbox-disk-size 2000 dhalsim-vm

docker-machine ls 

docker-machine active

docker-machine env dhalsim-vm  

farklı terminallerde docker komutunun çalışması için:
eval $(docker-machine env dhalsim-vm)

docker-machine start

docker-machine stop

## Docker

docker info 

docker images

docker ps -a

docker history ubuntu

docker run ubuntu sleep 10

docker run ubuntu echo "merhaba dünya"