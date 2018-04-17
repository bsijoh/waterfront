FROM bsijoh/waterfront_python_sp:base

LABEL description="Image containing the python3 stack for scientific computing with additional python modules (graph libraries)."

USER root

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
    
# non-packaged python tools
RUN pip3 install networkx

####### LET THE BUILD BEGIN
# create temporary directory
RUN mkdir /BUILD_TMP_graph_tool

# switch to build directory
WORKDIR /BUILD_TMP_graph_tool
RUN git clone https://git.skewed.de/count0/graph-tool.git
WORKDIR /BUILD_TMP_graph_tool/graph-tool
RUN ./autogen.sh
#make configure script use python3
RUN LD_LIBRARY_PATH=/usr/local/lib64:/usr/lib64 PYTHON=python3 ./configure
# you may try with -jx, x>1 but memory!
RUN make -j1
RUN make check
RUN make install

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
RUN rm -rf /BUILD_TMP_graph_tool

# doesn't hurt, right?
RUN ldconfig

####### Finish Building Container
# reset USER and WORKDIR
USER $WATERFRONT_USER
WORKDIR /home/$WATERFRONT_USER

ENTRYPOINT ["/bin/bash"]
