# About

This Docker image which provides an environment with [python3](https://www.python.org/) and an assortment of hand-curated packages for scientific computing and exposes them via [Jupyter](https://jupyter.org/) notebooks.
This images is based on the official [openSUSE image](https://hub.docker.com/_/opensuse/).

## Provided software
This is not an exhaustive list, just the major points:

From the openSUSE repositories:

* [python3](https://www.python.org/)
* [numpy](http://www.numpy.org/)
* [scipy](https://www.scipy.org/)
* [z3](https://github.com/Z3Prover/z3.git) with python3 bindings
* [matplotlib](https://matplotlib.org/) with cairo and latex backend
* [seaborn](https://seaborn.pydata.org/)
* [pandas](https://pandas.pydata.org/)
* [nlopt](http://ab-initio.mit.edu/nlopt) installed from openSUSE Build Service
* [graph_tool](https://graph-tool.skewed.de/) installed from openSUSE Build Service
* [networkx](https://networkx.github.io) installed from pip
* [pysmt](https://stackoverflow.com/questions/23450572/which-logics-are-supported-by-z3) installed from pip
* [pyomo](http://www.pyomo.org) installed from pip
* [control](https://github.com/python-control/python-control) installed from pip
* [slycot](https://github.com/python-control/python-control) installed from pip

# Build

Building the image is nothing special (look at the Dockerfile and entrypoint.sh). Something like:

```
cd <directory containing Dockerfile and entrypoint.sh>
docker build --tag <your tag for the image, e.g. tumbling_jupyter> .
```

Depending on your firewall setup, you might have to adjust the `--network` option.
In the following, we are going to assume, that the image is called `tumbling_jupyter`.

#  Usage

Just starting the container, e.g. with `docker run --rm -p8888:8888 tumbling_jupyter` should print some output regarding the start of the jupyter server.

```
    To access the notebook, open this file in a browser:
        file:///home/morelia>/.local/share/jupyter/runtime/nbserver-1-open.html
    Or copy and paste one of these URLs:
        http://(<strange characters> or 127.0.0.1):8888/?token=<token, eg. abcd1234...>

```
You need the `<token>` later. Here, `morelia` is the username inside the container and the `<strange characters>` in the listing above are the hostname of the container.
In theory (depending on your firewall), you can adjust the port where jupyter can be accessed with the `--publish` flag

```
docker run --rm -p8888:<hostport> tumbling_jupyter

```
But for me this only works with `-p8888:8888`.

The jupyter server can now be accessed on the host machine by entering `https://localhost:8888/?token=<your token>` or `https://127.0.0.1:8888/?token=<your token>`.

I think, you want ephemeral containers, hence the `--rm` flag. Since the `--rm` option deletes the container after it stops, your data should probably not be stored in the container. You can use `--volume` (or short `-v`) option for that:

```
docker run --rm -v<hostdir>:/mnt/mntpt1/jupyter_stuff -p8888:8888 tumbling_jupyter

```
Note that (as can be seen in entrypoint.sh) the jupyter notebook-dir is set to `/mnt/mntpt1` inside the container. To make sure that you don't have problems with file access / ownership, you should pass the user id of the owner of the `<hostdir>` in the environment variable `LOCAL_USER_ID` when starting the container

```
docker run --rm -e LOCAL_USER_ID=<uid of owner of hostdir> -v<hostdir>:/mnt/mntpt1/test_jup  tumbling_jupyter
```
If your user is the owner of `<hostdir>`, say `<hostdir>` is somewhere in your users home-directoy, you can use

```
docker run --rm -e LOCAL_USER_ID=`id -u $USER` -v/home/myuser/jupyter_stuff:/mnt/mntpt1/jupyter_stuff  tumbling_jupyter

```

## TLDR

```
docker run --rm -e LOCAL_USER_ID=`id -u $USER` -v<host directory owned by $USER>:/mnt/mntpt1/<directory in container> -p8888:<hostport> <image name>

```



# Security

Bad. Well actually, the jupyter-server shouldn't run as root, but `docker exec -it <a jupyter container>` lands you on a bash with root (inside the container), so at least root access to the mounted volume on the host system can be expected. Also, I don't know the intricacies of [gosu](https://github.com/tianon/gosu).
