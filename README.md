# restriction-example

This project demonstrates how we can config the application's host to treat the application as multiple services.  
This is very useful if we want to keep everything in one project and make the development process easy and simple

## Examine the application
### Running the application in dev mode

You can run your application in dev mode that enables live coding using:
```shell script
./gradlew quarkusDev
```

> **_NOTE:_**  Quarkus has a Swagger UI, which is available in dev mode only at http://localhost:8080/q/swagger-ui/.

### Testing the application endpoints
The application itself doesn't restrict any access to the endpoints, both for `/api` and `/twillio`  
you cant test it by going to:  
- http://localhost:8080/api/something  
- http://localhost:8080/api/anything  
- http://localhost:8080/twillio  

## Simulate host restriction on the application
For this example I use [Docker-compose](https://docs.docker.com/compose/install/) to simulate the host  
The Docker launches two containers in their own network: 
1. `api-server`: The application, which is not exposed outside its network
2. `api-router`: Nginx, exposed to port `9443` which handles all the requests and re-route them according to our configuration

### Running the application in a container
All we need to do is build and start our containers  
From the root of our project, open terminal and type in:
```shell
docker compose build
```
```shell
docker compose up -d
```

> **_NOTE:_**  For older versions of docker you may need to install `Docker-compose` as a standalone [like so](https://docs.docker.com/compose/install/standalone/)
> and run:
> ```shell
> docker-compose build
>```
> ```shell
> docker-compose up -d
>```

### Testing the container endpoints
Now that `Nginx` handles our requests, lets test again our endpoints:
- http://localhost:9443/api/something
- http://localhost:9443/api/anything
- http://localhost:9443/twillio  

Note that the last request ended with `401 Unauthorized`.  
But if we go to http://localhost:9090/ we're able to reach the endpoint as if it was a different service