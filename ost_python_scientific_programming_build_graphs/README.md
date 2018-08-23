#Deprecated!
#/!\ not supported, as long as graph_tool can be build with [OBS](https://build.opensuse.org/package/show/home:bsijoh/python3-graph_tool)

# About

This Docker image which provides an environment with [python3](https://www.python.org/) and some packages for scientific computing.
This images is based on the official [openSUSE image](https://hub.docker.com/_/opensuse/).

## Provided software
In addition to the software in the base image, this image contains the following:

Installed via pip:

* [networkx](https://networkx.github.io)

Built during creation of the image:

* [graph_tool](https://graph-tool.skewed.de/)


#  Usage

If you start the container, your entrypoint is ```bash```, from where on you should know how to continue.