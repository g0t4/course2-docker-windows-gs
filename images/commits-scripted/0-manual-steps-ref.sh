# run nginx web container (simulate a running machine)
docker container run -i -t -p 8080:80 --name web nginx

# before
curl localhost:8080 # returns default page
docker container diff web # ≈empty + runtime state if testing
# replace page
docker container cp index.html web:/usr/share/nginx/html/index.html
# after
docker container diff web # + custom page
curl localhost:8080 # returns custom page


docker image ls # before
# create image
docker container commit web nginx-commits
docker image ls # after (+ nginx-commits image)


# testing afterwards
curl localhost:8081 # before (site offline)
docker container run -i -t -p 8081:80 --name web-commits nginx-commits
curl localhost:8081 # after

