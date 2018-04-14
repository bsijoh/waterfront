# About this Repo

This is the Git repo of a Docker image which provides an environment with [python3](https://www.python.org/) and some packages for scientific computing.
This images is based on the official [openSUSE image](https://hub.docker.com/_/opensuse/).

## Provided software
This is not an exhaustive list, just the major points:

From the openSUSE repositories:

* [python3](https://www.python.org/)
* [numpy](http://www.numpy.org/)
* [scipy](https://www.scipy.org/)
* [matplotlib](https://matplotlib.org/) with cairo and latex backend
* [pandas](https://pandas.pydata.org/)

Built during creation of the image:

* [graph_tool](https://graph-tool.skewed.de/)


#  Usage

If you start the container, your entrypoint is ```bash```. from where on you should know how to continue.