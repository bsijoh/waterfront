docker run --rm -e LOCAL_USER_ID=`id -u $USER` -v`pwd`:/mnt/mntpt1/jupyter_stuff -p8888:8888 --name jupyter_in_container bsijoh/waterfront_interactive_tumbleweed
