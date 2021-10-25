set -x

# testing afterwards
curl localhost:8082 # before (site offline)
docker container run -d -p 8082:80 --name web-commits2 nginx-commits2
sleep 3s
curl localhost:8082 # after

docker container stop web-commits2
docker container rm web-commits2