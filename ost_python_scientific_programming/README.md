# About

This Docker image which provides an environment with [python3](https://www.python.org/) and some packages for scientific computing.
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
* [jupyter](https://jupyter.org/)
* [graph_tool](https://graph-tool.skewed.de/) installed from openSUSE Build Service
* [networkx](https://networkx.github.io) installed from pip
* [pysmt](https://stackoverflow.com/questions/23450572/which-logics-are-supported-by-z3) installed from pip
 

#  Usage

If you start the container, your entrypoint is ```bash```, from where on you should know how to continue.
