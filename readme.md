docker build --no-cache=true -t skuarch/mysql:latest .

docker run --name mysql -itd -p 3306:3306 skuarch/mysql:latest 

docker start mysql

docker exec -it mysql /bin/bash