# first check host timezone:
hostname; (get-timezone).DisplayName; (get-date).ToShortTimeString();

# build all images
docker build --tag no-set-tz `
  --file Dockerfile.no-set-tz .

docker build --tag set-tz:nanoserver `
  --file Dockerfile.set-tz-nanoserver .

docker build --tag set-tz:servercore `
  --file Dockerfile.set-tz-servercore .

# check again
hostname; (get-timezone).DisplayName; (get-date).ToShortTimeString();

# run examples
docker container run --rm -it no-set-tz
docker container run --rm -it set-tz:servercore

# check again
hostname; (get-timezone).DisplayName; (get-date).ToShortTimeString();