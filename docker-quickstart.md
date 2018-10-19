# Docker Quickstart

## Install

Follow the installation instructions for
[docker](https://docs.docker.com/install/) and
[docker-compose](https://docs.docker.com/compose/install/)

(docker-compose may or may not come with docker on your platform)

## Run

``` bash
docker-compose up
```

the ui be served at `http://localhost:8000`

## selenium tests

``` bash
docker-compose \
  -f docker-compose.yml \
  -f docker-compose.override.yml \
  -f docker/docker-compose.test.yml \
  run selenium
```

## node_modules

if you need to update node modules run:

```bash
docker-compose exec app yarn
```

in general you can run anything in the app container with

```
docker-compose exec app <command>
```
