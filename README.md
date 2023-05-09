# minecraft-bedrock-arm64-docker
Run the minecraft bedrock server in an ARM64 environment.

## Quick start
```
docker run -itd --rm -e EULA=TRUE -e GAMEMODE=survival -p 19132:19132/udp  abeyuki/minecraft-bedrock-arm64:1.19.81.01
```

## docker compose

```
docker compose up -d
```

## build

```
cd build/
```
```
docker compose up -d
```