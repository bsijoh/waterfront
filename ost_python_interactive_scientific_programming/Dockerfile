FROM opensuse/tumbleweed

LABEL description="Image containing the python3 stack and jupyter."

# these default values are used, if not provided while running build script
ENV WATERFRONT_USER=morelia
ENV WATERFRONT_UID=9999

######## CREATE USER
# this is solved via gosu later in entrypoint script


###### Packages
# repository for own packages with higher priority
RUN set -eux; \
    zypper --non-interactive \
        --gpg-auto-import-keys addrepo \
        --priority 90 \
        --repo https://download.opensuse.org/repositories/home:/bsijoh/openSUSE_Tumbleweed/home:bsijoh.repo; \
    zypper --non-interactive --gpg-auto-import-keys refresh; \
    zypper --non-interactive install \
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
        python3-matplotlib-web \
        python3-seaborn \
        python3-xlrd \
        python3-openpyxl \
        python3-pandas \
        python3-pip \
        pandoc \
        texlive-scheme-small \
        texlive-mathpazo \
        texlive-fpl \
        texlive-palatino \
        texlive-psnfss \
        texlive-caption \
        texlive-adjustbox \
        texlive-tcolorbox \
        jupyter \
        jupyter-doc \
        jupyter-qgrid \
        jupyter-vispy \
        jupyter-nbdime \
        jupyter-ipympl \
        jupyter-notebook \
        jupyter-nbformat \
        jupyter-jupytext \
        jupyter-ipysheet \
        jupyter-nbconvert \
        jupyter-ipykernel \
        jupyter-hide_code \
        jupyter-ipyscales \
        jupyter-notebook-latex \
        jupyter-nbconvert-latex \
        jupyter-jupyter_latex_envs \
        jupyter-ipydatawidgets \
        jupyter-widgetsnbextension \
        jupyter-jupyter_nbextensions_configurator \
        jupyter-jupyter_highlight_selected_word \
        jupyter-jupyter-full-width \
        jupyter-jupyter-server \
        jupyter-jupyter_console \
        jupyter-jupyter-require \
        jupyter-jupyterbgnotify; \
    \
    # python serialization
    pip3 install --no-cache-dir dill; \
    # network/graph libraries
    # install stuff from openSUSE Build Service    
    zypper --non-interactive install python3-graph_tool; \
    pip3 install --no-cache-dir networkx; \
    \
    # smt stuff
    zypper --non-interactive install \    
        z3 \
        z3-devel \
        python3-z3; \
    pip3 install --no-cache-dir pysmt; \
    \
    # optimization stuff
    # install stuff from openSUSE Build Service    
    zypper --non-interactive install python3-nlopt; \
    pip3 install --no-cache-dir \
        pyomo \
        pulp; \
    \
    # control stuff
    # requirements for slycot
    zypper --non-interactive install \
        python3-numpy-devel \
        cmake \
        gcc-fortran; \
    # next is required, else slycot won't build
    ln -s /usr/lib64/python3.7/site-packages/numpy /usr/lib/python3.7/site-packages/numpy; \
    # scikit-build used by slycot
    pip3 install --no-cache-dir \   
        scikit-build; \
    pip3 install --no-cache-dir \   
        scikit-build \
        slycot \
        control; \
    zypper --non-interactive remove --clean-deps \
        python3-numpy-devel \
        cmake \
        gcc-fortran;
    
######## gosu
# here be the lates gosu version number
ENV GOSU_VERSION 1.11

RUN set -eux;\
    zypper --non-interactive install \
            wget \
            dpkg; \
    dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
	wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
	\
# verify the signature
	export GNUPGHOME="$(mktemp -d)"; \
# for flaky keyservers, consider https://github.com/tianon/pgp-happy-eyeballs, ala https://github.com/docker-library/php/pull/666
	gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
	command -v gpgconf && gpgconf --kill all || :; \
	rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc; \
	chmod +x /usr/local/bin/gosu; \
# verify that the binary works
	gosu --version;\
	zypper --non-interactive remove --clean-deps \
        wget \
        dpkg;

####### Finish Building Container

RUN zypper clean --all;

# set locale
RUN sed "s/RC_LC_ALL=\"\"/RC_LC_ALL=\"en_US.UTF-8\"/g" --in-place /etc/sysconfig/language;
ENV LC_ALL="en_US.UTF-8"

# for sshfs / fuse
RUN set -eux;\
    ldconfig; \
    chmod +x /usr/bin/fusermount3; \
    mkdir /mnt/mntpt1;


EXPOSE 8888


COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh;


ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
#ENTRYPOINT ["/bin/bash"]
