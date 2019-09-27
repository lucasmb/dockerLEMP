#Initial Setup PHP Dev Environment:

1. Clone this project
      git clone https://github.com/xxxx/xxxx.git lempEnv

2. Clonar your project if needed
`git clone https://github.com/xxxx/xxxx.git awesomeapp`

Make a symbolic link of your project folder to lempEnv/application
3. Make a symbolic link of your project folder to lempEnv/application
```ej: cd /home/user/lempEnv
ln -s /home/user/project/superApp application `

4. If you need to install composer dependencies run compser from a docker image that will be autodelted after installing
``` cd /home/user/devEnv/application
 sudo docker run --rm -v $(pwd):/app composer install
 ```

5. Rename and edit the lempEnv/.env.example to .env 
also, if you use laravel, edit the  Laravel env file to use the docker DB
``` cd /home/user/devEnv/application
    cp .env.example .env
 ```
```
DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=awesomedb
DB_USERNAME=db_user
DB_PASSWORD=db_pass

```

6. start the containers
`sudo docker-compose up -d`

7. You will see (app, db y webserver) running
`sudo docker -ps`

8. Every artisan or npm command must be run from the app container
```
sudo docker-compose exec app php artisan key:generate
sudo docker-compose exec app php artisan migrate
sudo docker-compose exec app npm install
```



#Docker Commands:

###start docker-compose
`docker-compose up (-d for deteched mode)`

###stop docker-compose
`docker-compose down (--rmi all 'for removing images after stop') `

###list containers
`docker ps `

###access docker container
`docker exec -it <mycontainer> bash`

###execute command on container
`docker exec -it phpenv_php-fpm ip addr`