# waterfront
This repository contains resources for the Docker infrastructure to automate building docker images. This repository should be used by Docker Hubs automated build process.

Subfolders contain the `Dockerfile` and `README.md` for images.

# Most important Docker commands

Delete all of those containers. They should be ephemeral anyway.

```
docker rm $(docker ps -a -q)
```

Delete all of those images. Always build them fresh (or pull from a repository, which builds them continously).

```
docker rmi $(docker images -q)
```
