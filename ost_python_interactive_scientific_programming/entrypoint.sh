#!/bin/bash

# Add user in container
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback to WATERFRONT_UID
USER_ID=${LOCAL_USER_ID:-$WATERFRONT_UID}

echo "Starting with UID : $USER_ID"
useradd --create-home --shell /bin/bash --uid $USER_ID $WATERFRONT_USER --non-unique --groups users

chown $WATERFRONT_USER:users /mnt/mntpt1

#exec /usr/local/bin/gosu $WATERFRONT_USER "$@"
exec /usr/local/bin/gosu $WATERFRONT_USER /usr/bin/jupyter-notebook --ip=0.0.0.0 --notebook-dir=/mnt/mntpt1
