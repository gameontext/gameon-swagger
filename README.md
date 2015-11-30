# Game On! Swagger API Documentation

This project contains a Game On! room implemented in Node.js

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


