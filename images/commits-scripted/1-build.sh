set +x

# create nginx web container (simulate a running machine)
docker container create --name web2 nginx

# before
docker container diff web2 # ≈empty + runtime state if testing
# replace page
docker container cp index.html web2:/usr/share/nginx/html/index.html
# after
docker container diff web2 # + custom page


docker image ls # before
# create image
docker container commit web2 nginx-commits2
docker image ls # after (+ nginx-commits image)
