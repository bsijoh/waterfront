# About

This Docker image provides an environment for rpm-packaging. If packages can be build in here, they could be uploaded to openSUSE Build Service (OBS).

#  Usage

/!\ Default user can sudo without password! Use only for experimenting with the rpmbuild / openSUSE Build Service System.

/!\ If this container is being run on a machine, where other users might attach to your container, they could access the OBS credentials.

/!\ For reasons unknown, it seems that this container needs to be run in ```--privileged``` mode, else there is a problem with ```/dev/fd/62``` while building the package.

__In conclusion__: Only run on your own computer.

```
docker pull bsijoh/waterfront_images:ost_rpm_packaging_base
docker run --privileged --interactive --tty --name packaging_graphtool bsijoh/waterfront_images:ost_rpm_packaging_base
```

If you start the container, your entrypoint is ```bash```, from where on you should know how to continue.

# openSUSE Build Service

see [openSUSE-wiki](https://de.opensuse.org/openSUSE:Build_Service_Anleitung) for more details:

__Checkout__ home repository into container
```
cd <directory_to_contain_project_root>
osc checkout home:<username>
cd home:<username> 
```

__Commit__ changes in repository
```
osc commit
```
for this command, the current directory should be the directory of the package you were changing.

__Add__ changed files (e.g. source files), when necessary.
```
osc add <file>
```


__Build__ from .spec-file
```
#osc build <platform> <arch> specfile
osc build openSUSE_Tumbleweed x86_64 specfile
```