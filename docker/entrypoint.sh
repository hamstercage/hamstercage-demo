#!/bin/sh

# start nginx in the background, then exec bash for interactive use

nginx
exec /bin/bash $@
