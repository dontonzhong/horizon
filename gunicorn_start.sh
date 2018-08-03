#!/bin/bash

NAME="horizon"
DJANGODIR=/Users/zhong/Projects/Django/horizon/horizon
SOCKFILE=/Users/zhong/Projects/Django/horizon/run/gunicorn.sock
USER=zhong
GROUP=staff
NUM_WORKERS=1
DJANGO_SETTINGS_MODULE=horizon.settings
DJANGO_WSGI_MODULE=horizon.wsgi

echo "Starting $NAME as `whoami`"

cd $DJANGODIR
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
RUNDIR=$(dirname $SOCKFILE)
test -d $RUNDIR || mkdir -p $RUNDIR


exec /usr/local/bin/gunicorn ${DJANGO_WSGI_MODULE}:application \
  --name $NAME  \
  --workers $NUM_WORKERS \
  --user $USER \
  --bind=unix:$SOCKFILE
