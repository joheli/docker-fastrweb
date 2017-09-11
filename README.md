# docker-fastrweb

(The Dockerfile in this repository is linked to an automated build at https://hub.docker.com/r/johanneselias/fastrweb)

## Prerequisites

You need to have docker and, optionally, docker-compose installed.

## Want to spin up a Docker container containing FastRWeb?

Easy.

First, clone the contents onto your computer by typing

    git clone https://github.com/joheli/docker-fastrweb
    
Then cd into directory 'docker-fastrweb' and type

    docker run -d -p 80:80 -v $PWD/R:/var/FastRWeb/web.R -v $PWD/php:/var/www/html --name fast johanneselias/fastrweb

Alternatively, use docker-compose and type

    docker-compose up -d
    
## Check it out

If all went according to plan, you should be able to see the result in your browser. Open the IP address of your container (e.g. http://localhost)

## I want to use my own R- and php-files

Please put those into the directory 'R' and 'php', respectively. Then spin up the container again.
