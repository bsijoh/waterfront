FROM opensuse:latest

LABEL description="Image containing the python3 stack for scientific computing with some python modules built from source."

# these default values are used, if not provided while running build script
ARG user=morelia
ARG uid=9999

######## CREATE USER
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
    python3-pip

###### Building graph tool

# create temporary directory
RUN mkdir /home/$user/BUILD
RUN chown $user:users /home/$user/BUILD

# install newer version of cgal
RUN zypper addrepo --refresh https://download.opensuse.org/repositories/graphics/openSUSE_Leap_42.3/graphics.repo
RUN zypper --gpg-auto-import-keys --non-interactive install --from graphics \
    libCGAL13 \
    cgal-devel

# install devel-packages and build-tools for graph_tool
RUN zypper --non-interactive install \
    autoconf \
    automake \
    m4 \
    libtool \
    pkg-config \
    gcc7-c++ \
    expat \
    libexpat-devel \
    libstdc++6 \
    libstdc++-devel \
    python3-devel \
    boost_1_61-devel \
    libgmpxx4 \
    libgmp10 \
    gmp-devel \
    python3-numpy-devel \
    cairomm \
    cairomm-devel \
    python3-cairo \
    python3-cairo-devel \
    sparsehash-devel \
    libgomp1

# switch to build directory
WORKDIR /home/$user/BUILD
RUN git clone https://git.skewed.de/count0/graph-tool.git
WORKDIR /home/$user/BUILD/graph-tool
RUN ./autogen.sh
# make configure script use python3 and gcc7 (gcc4.8 is too old)
RUN LD_LIBRARY_PATH=/usr/local/lib64:/usr/lib64 PYTHON=python3 CXX=/usr/bin/g++-7 ./configure
# you may try with -jx, x>1 but memory!
RUN make -j1
RUN make check
RUN make install

RUN ldconfig

# non-packaged python tools
RUN pip3 install networkx


####### CLEAN-UP

# search all -devel packages, skip to line where package names are and feed package name in zypper remove
RUN  zypper search --installed devel | tail -n+6 | awk '{print $3}' | xargs zypper --non-interactive remove --clean-deps

# remove stuff we needed for building graph_tool
RUN zypper --non-interactive remove --clean-deps \
    autoconf \
    automake \
    m4 \
    libtool
    
# probably even more packages can be removed, only I don't know yet.
    
# unfortunately boost packages are removed when removing all devel packages.
RUN zypper --non-interactive install  \
    boost_1_61-devel

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
