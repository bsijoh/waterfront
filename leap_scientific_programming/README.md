# About

This Docker image which provides an environment with [python3](https://www.python.org/) and an assortment of hand-curated packages for scientific computing.
This images is based on the official [openSUSE image](https://hub.docker.com/_/opensuse/) for the „stable“ variant called Leap.

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
* [glpk](https://www.gnu.org/software/glpk/) to have at least one ILP solver aboard

From the openSUSE "home"-repositories:

* [nlopt](http://ab-initio.mit.edu/nlopt) installed from openSUSE Build Service
* [graph_tool](https://graph-tool.skewed.de/) installed from openSUSE Build Service

Systemwide pip-installation

* [networkx](https://networkx.github.io)
* [pysmt](https://stackoverflow.com/questions/23450572/which-logics-are-supported-by-z3)
* [pyomo](http://www.pyomo.org)
* [control](https://github.com/python-control/python-control)
* [slycot](https://github.com/python-control/python-control)
* [dill](https://pypi.org/project/dill/)
* [cloudpickle](https://github.com/cloudpipe/cloudpickle)

#  Usage

If you start the container, your entrypoint is ```bash```, from where on you should know how to continue.
