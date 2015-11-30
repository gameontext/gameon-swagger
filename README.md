# Game On! Swagger API Documentation

This project contains the Game On! APIs documented in Swagger.

## Docker

### Building

```
docker build -t gameon-room-swagger
```

### Interactive Run

```
docker run -it -p 3001:3000 --env-file=./dockerrc --name gameon-swagger gameon-swagger bash
```

### Daemon Run

```
docker run -d -p 3001:3000 --env-file=./dockerrc --name gameon-swagger gameon-swagger
```

### Stop

```
docker stop gameon-swagger ; docker rm gameon-swagger
```

### Restart Daemon

```
docker stop gameon-swagger ; docker rm gameon-swagger ; docker run -d -p 3001:3000 --env-file=./dockerrc --name gameon-swagger gameon-swagger
```


