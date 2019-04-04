# About

This Docker image which provides an environment with [python3](https://www.python.org/) and an assortment of hand-curated packages for scientific computing.
This images is based on the official [openSUSE image](https://hub.docker.com/_/opensuse/).

## Provided software
This is not an exhaustive list, just the major points:

* [python3](https://www.python.org/)
* [numpy](http://www.numpy.org/)
* [scipy](https://www.scipy.org/)
* [z3](https://github.com/Z3Prover/z3.git) with python3 bindings
* [matplotlib](https://matplotlib.org/) with cairo and latex backend
* [seaborn](https://seaborn.pydata.org/)
* [pandas](https://pandas.pydata.org/)
* [nlopt](http://ab-initio.mit.edu/nlopt) installed from openSUSE Build Service
* [glpk](https://www.gnu.org/software/glpk/)
* [graph_tool](https://graph-tool.skewed.de/) installed from openSUSE Build Service
* [networkx](https://networkx.github.io) installed from pip
* [pysmt](https://stackoverflow.com/questions/23450572/which-logics-are-supported-by-z3) installed from pip
* [pyomo](http://www.pyomo.org) installed from pip
* [control](https://github.com/python-control/python-control)
* [slycot](https://github.com/python-control/python-control)
* [dill](https://pypi.org/project/dill/)
* [cloudpickle](https://github.com/cloudpipe/cloudpickle)

#  Usage
If you start the container, your entrypoint is `bash`, from where on you should know how to continue.
Note, that the user inside the container defaulty to `morelia`, but you can give him the same UID as your local user by
starting the container with:
```
docker run --rm -e LOCAL_USER_ID=`id -u $USER` <image name>
```

If it doesn't work, check what SELinux does. Or apparmor.

# Security

Bad...

 Well actually, [gosu](https://github.com/tianon/gosu) is used to drop the bash to a non-root user, but `docker exec -it <container>` lands you on a bash with root (inside the container), so at least root access to the mounted volume on the host system can be expected. Also, I don't know the intricacies of [gosu](https://github.com/tianon/gosu).