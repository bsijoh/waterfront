FROM opensuse:tumbleweed

LABEL description="Image containing the python3 stack for scientific computing with some python modules built from source."

# these default values are used, if not provided while running build script
ARG user=morelia
ARG uid=9999

######## CREATE USER
# This is a dumb idea, only allowed for debbuging.
#RUN zypper --non-interactive in sudo
#RUN useradd --create-home --shell /bin/bash --uid $uid $user --groups users
#RUN echo "$user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Use this one instead,
RUN useradd --create-home --shell /bin/bash --uid $uid $user --groups users


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
    python3-pandas \
    python3-pip \
    python3-jupyter \
    python3-jupyter_console \
    python3-jupyter_notebook \
    python3-jupyter_notebook-latex \
    python3-jupyter_ipywidgets \
    python3-jupyter_ipyparallel

###### Building graph tool

# create temporary directory
RUN mkdir /home/$user/BUILD
RUN chown $user:users /home/$user/BUILD
    
# install devel-packages and build-tools for graph_tool
RUN zypper --non-interactive install \
    autoconf \
    automake \
    m4 \
    libtool \
    pkg-config \
    gcc-c++ \
    expat \
    libCGAL13 \
    cgal-devel \
    libexpat-devel \
    libstdc++6 \
    libstdc++-devel \
    python3-devel \
    boost-devel \
    libboost_python-py3-1_66_0 \
    libboost_python-py3-1_66_0-devel \
    libboost_iostreams1_66_0 \
    libboost_iostreams1_66_0-devel \
    libboost_regex1_66_0 \
    libboost_regex1_66_0-devel \
    libboost_context1_66_0 \
    libboost_context1_66_0-devel \
    libboost_graph1_66_0 \
    libboost_graph1_66_0-devel \
    libboost_graph_parallel1_66_0 \
    libboost_graph_parallel1_66_0-devel \
    libboost_coroutine1_66_0 \
    libboost_coroutine1_66_0-devel \
    libboost_thread1_66_0 \
    libboost_thread1_66_0-devel \
    libgmpxx4 \
    libgmp10 \
    gmp-devel \
    python3-numpy-devel \
    cairomm-devel \
    libcairomm-1_0-1 \
    cairomm1_0-devel \
    python3-cairo \
    python3-cairo-devel \
    sparsehash-devel \
    libgomp1 \
    python3-gobject-cairo \
    typelib-1_0-Gtk-3_0

# switch to build directory
WORKDIR /home/$user/BUILD
RUN git clone https://git.skewed.de/count0/graph-tool.git
WORKDIR /home/$user/BUILD/graph-tool
RUN ./autogen.sh
#make configure script use python3
RUN LD_LIBRARY_PATH=/usr/local/lib64:/usr/lib64 PYTHON=python3 ./configure
# you may try with -jx, x>1 but memory!
RUN make -j1
RUN make check
RUN make install

RUN ldconfig
 
# non-packaged python tools
RUN pip3 install networkx


####### CLEAN-UP
# remove stuff we needed for building graph_tool
RUN zypper --non-interactive remove --clean-deps \
    autoconf \
    automake \
    m4 \
    libtool

# search all -devel packages, skip to line where package names are and feed package name in zypper remove
RUN zypper search --installed devel | tail -n+6 | awk '{print $3}' | xargs zypper --non-interactive remove --clean-deps; exit 0
    
# probably even more packages can be removed, only I don't know yet.

#delete the BUILD directory, after we installed graph_tool
RUN rm -rf /home/$user/BUILD


####### Finish Building Container
WORKDIR /home/$user/
RUN ldconfig

# for sshfs / fuse
RUN chmod +x /usr/bin/fusermount
RUN mkdir /mnt/mntpt1
RUN chown $user:users /mnt/mntpt1

USER $user
WORKDIR /home/$user

ENTRYPOINT ["/bin/bash"]
