#!/bin/sh

python manage.py migrate
python manage.py collectstatic --noinput

if [ -n "$DJANGO_SUPERUSER_USERNAME" ] && [ -n "$DJANGO_SUPERUSER_EMAIL" ] && [ -n "$DJANGO_SUPERUSER_PASSWORD" ]; then
    python manage.py createsuperuser --no-input || true
fi

gunicorn --bind 0.0.0.0:${BACKEND_PORT} conduit.wsgi:application