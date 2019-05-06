FROM opensuse/leap

LABEL description="Image containing the applications for scientific computing."

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
    --repo https://download.opensuse.org/repositories/home:/bsijoh/openSUSE_Leap_15.0/home:bsijoh.repo
    
RUN zypper --non-interactive --gpg-auto-import-keys refresh 

#generic stuff
RUN zypper --non-interactive install \
    vim \
    bash \
    git \
    glibc-locale \
    sshfs \
    python3 \
    python3-xmltodict \
    python3-numpy \
    python3-scipy \
    python3-matplotlib \
    python3-matplotlib-cairo \
    python3-matplotlib-latex \
    python3-seaborn \
    python3-pandas \
    python3-pip
    
RUN pip3 install --no-cache-dir \
    dill \
    cloudpickle


# network/graph libraries
# install stuff from openSUSE Build Service    
RUN zypper --non-interactive install \
    python3-graph_tool

RUN pip3 install --no-cache-dir \
    networkx    
    
# smt stuff
RUN zypper --non-interactive install \    
    z3 \
    z3-devel \
    python3-z3
    
RUN pip3 install --no-cache-dir \
    pysmt
    
# optimization stuff
# install stuff from openSUSE Build Service    
RUN zypper --non-interactive install \
    python3-nlopt \
    glpk
    
RUN pip3 install --no-cache-dir \
    pyomo \
    pulp
    
# control stuff
# requirements for slycot
RUN zypper --non-interactive install \
        python3-numpy-devel \
        cmake \
        gcc-fortran;
    # next is required, else slycot won't build
RUN ln -s /usr/lib64/python3.6/site-packages/numpy /usr/lib/python3.6/site-packages/numpy;
    # scikit-build used by slycot
RUN    pip3 install --no-cache-dir \   
        scikit-build;
RUN pip3 install --no-cache-dir \   
        scikit-build \
        slycot \
        control;
RUN zypper --non-interactive remove --clean-deps \
        python3-numpy-devel \
        cmake \
        gcc-fortran;
    
####### Finish Building Container

RUN zypper clean --all

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
