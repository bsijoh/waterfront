FROM opensuse/tumbleweed

LABEL description="Image containing the python3 stack for scientific computing."

# these default values are used, if not provided while running build script
ENV WATERFRONT_USER=morelia
ENV WATERFRONT_UID=9999

######## CREATE USER
# This is a dumb idea, only allowed for debbuging.
#RUN zypper --non-interactive in sudo
#RUN useradd --create-home --shell /bin/bash --uid $WATERFRONT_UID $WATERFRONT_USER --groups users
#RUN echo "$WATERFRONT_USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Use this one instead,
RUN useradd --create-home --shell /bin/bash --uid $WATERFRONT_UID $WATERFRONT_USER --groups users


###### Packages
# repository for own packages with higher priority
RUN zypper --non-interactive \
    --gpg-auto-import-keys addrepo \
    --priority 90 \
    --repo https://download.opensuse.org/repositories/home:/bsijoh/openSUSE_Tumbleweed/home:bsijoh.repo
    
RUN zypper --non-interactive --gpg-auto-import-keys refresh 

#generic stuff
RUN zypper --non-interactive install \
    vim \
    bash \
    git \
    glibc-locale \
    sshfs \
    python3 \
    python3-numpy \
    python3-scipy \
    python3-matplotlib \
    python3-matplotlib-cairo \
    python3-matplotlib-latex \
    python3-seaborn \
    python3-pandas \
    python3-pip


# network/graph libraries
# install stuff from openSUSE Build Service    
RUN zypper --non-interactive install \
    python3-graph_tool

RUN pip3 install networkx    
    
# smt stuff
RUN zypper --non-interactive install \    
    z3 \
    z3-devel \
    python3-z3
    
RUN pip3 install pysmt
    
# optimization stuff
# install stuff from openSUSE Build Service    
RUN zypper --non-interactive install \
    python3-nlopt   
    
RUN pip3 install \
    pyomo
    
# control stuff
# requirements for slycot
RUN zypper --non-interactive install \
    python3-numpy-devel \
    gcc-fortran

RUN pip3 install \
    slycot \
    control

RUN zypper --non-interactive remove --clean-deps \
    python3-numpy-devel \
    gcc-fortran
    
####### Finish Building Container

# set locale
RUN sed "s/RC_LC_ALL=\"\"/RC_LC_ALL=\"en_US.UTF-8\"/g" --in-place /etc/sysconfig/language
ENV LC_ALL="en_US.UTF-8"

WORKDIR /home/$WATERFRONT_USER/
RUN ldconfig

# for sshfs / fuse
RUN chmod +x /usr/bin/fusermount
RUN mkdir /mnt/mntpt1
RUN chown $WATERFRONT_USER:users /mnt/mntpt1

USER $WATERFRONT_USER
WORKDIR /home/$WATERFRONT_USER

ENTRYPOINT ["/bin/bash"]
