FROM opensuse:tumbleweed

LABEL description="Image containing the python3 stack for scientific computing with some python modules built from source."

# these default values are used, if not provided while running build script
ENV WATERFRONT_USER=morelia
ENV WATERFRONT_UID uid=9999

######## CREATE USER
# This is a dumb idea, only allowed for debbuging.
#RUN zypper --non-interactive in sudo
#RUN useradd --create-home --shell /bin/bash --uid $uid $WATERFRONT_USER --groups users
#RUN echo "$WATERFRONT_USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Use this one instead,
RUN useradd --create-home --shell /bin/bash --uid $WATERFRONT_UID $WATERFRONT_USER --groups users


###### Basic Packages
RUN zypper --non-interactive install \
    vim \
    bash \
    git \
    sshfs \
    python3 \
    python3-numpy \
    python3-scipy \
    python3-matplotlib \
    python3-matplotlib-cairo \
    python3-matplotlib-latex \
    python3-seaborn \
    python3-pandas \
    python3-pip \
    python3-jupyter \
    python3-jupyter_console \
    python3-jupyter_notebook \
    python3-jupyter_notebook-latex \
    python3-jupyter_ipywidgets \
    python3-jupyter_ipyparallel

####### Finish Building Container
WORKDIR /home/$WATERFRONT_USER/
RUN ldconfig

# for sshfs / fuse
RUN chmod +x /usr/bin/fusermount
RUN mkdir /mnt/mntpt1
RUN chown $WATERFRONT_USER:users /mnt/mntpt1

USER $WATERFRONT_USER
WORKDIR /home/$WATERFRONT_USER

ENTRYPOINT ["/bin/bash"]
