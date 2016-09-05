# Dockerized final-api application

This solution allows you to run Dockerized version of [Final-API](https://github.com/AVGTechnologies/final-api).

## What does it mean "dockerised"? What is the motivation?
Docker is a solution allowing definition of service containers, which you
can use for comfortable service deployment and cleanup.

This version of final-api targets to bring more comfort to the
developers.

## How can I use this solution?
* Clone this repository
* [Install Docker](https://docs.docker.com/engine/installation/linux/)
* Clone [Final-API](https://github.com/AVGTechnologies/final-api)
* Adjust the Final-API configs
* Prepare tsd validator in your final-api project
* Prepare env file in your final-api project
* Copy necessary certificates to ./certs
* Run the make script to prepare images
* Run the docker-compose up script to launch the docker for you
