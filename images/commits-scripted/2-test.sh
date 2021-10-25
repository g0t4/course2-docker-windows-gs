set -x

# testing afterwards
curl localhost:8081 # before (site offline)
docker container run -i -t -p 8081:80 --name web-commits2 nginx-commits2
curl localhost:8081 # after
