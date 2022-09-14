To build and deploy to the public Docker repository

````
docker build --no-cache -t cientopolis/gapafarm:latest .

docker tag cientopolis/gapafarm:latest cientopolis/gapafarm:[commit-hash]

docker push cientopolis/gapafarm:latest

docker push cientopolis/gapafarm:[commit-hash]
````

To deploy / run

````
sudo docker pull cientopolis/gapafarm:latest

sudo docker compose down

sudo docker compose up -d
````

