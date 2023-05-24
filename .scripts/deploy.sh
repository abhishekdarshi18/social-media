#!/bin/bash
set -e

echo "Deployment Started..."

# Pull the latest version of the App
git pull origin master
echo "New Changes copied to server !"

# Activate Virtual environment
. env/bin/activate
echo "Virtual Environment activated"

echo "Installing Dependencies..."
pip install -r requirements.txt

echo "Serving Static files"
python manage.py collectstatic --no-input

echo "Runnig Database Migrations"
python manage.py makemigrations
python manage.py migrate

# Deactivate the virtual environment
deactivate
echo "Virtual environment Deactivated"

# Server reloading to see the changes
pushd mysite
touch wsgi.py
popd

echo "Deployment Finished"
