# docker rm -f aria2-server
# aria2-server
docker build -t aria2-server .
docker run --net=host --rm   -e ARIA2_SECRET=asd --name aria2-server   aria2-server