# nelson-sio-docker

Docker official image for Nelson socket.IO client.

See the Docker Hub page for the full readme on how to use this Docker image and for information regarding contributing and issues.

## build docker

```bash
docker build -t nelson-sio-cli .
```

## download nelson image

```bash
docker pull nelsonsoftware/nelson-sio-cli
```

## run docker

```bash
docker run -ti nelson-sio-cli
```

## Release on dockerhub

```bash
docker rmi $(docker images -q) -f
docker system prune -a

docker build -t nelsonsoftware/nelson-sio-cli:latest -t nelsonsoftware/nelson-sio-cli:v0.7.1 .
docker push  nelsonsoftware/nelson-sio-cli:v0.7.1
docker push  nelsonsoftware/nelson-sio-cli:latest

```
