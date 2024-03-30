FROM python:3.10

WORKDIR /app

# Intall dependencies
COPY /requirements/development_requirements.txt /app/
COPY /requirements/base_requirements.txt /app/
COPY . /app

# Install dependencies
RUN pip install -r base_requirements.txt

# Install FOP 2.9
RUN wget https://storage.googleapis.com/server8koalixnet_backup/fop-2.9-bin.tar.gz
RUN tar -xzf fop-2.9-bin.tar.gz -C ../usr/bin
RUN rm -rf fop-2.9-bin.tar.gz
RUN chmod 755 /usr/bin/fop-2.9/fop/fop

# Install Java 8
RUN wget https://storage.googleapis.com/server8koalixnet_backup/jdk-8u181-linux-x64.tar.gz
RUN tar -xzf jdk-8u181-linux-x64.tar.gz -C ../usr/bin
RUN rm -rf jdk-8u181-linux-x64.tar.gz

# Create /media/uploads/ directory which is required by django filebrowser
RUN mkdir -p projectsettings/media/uploads
RUN chmod -R 755 projectsettings/media

# Create /static/pdf for FOP PDF export
RUN mkdir -p projectsettings/static/pdf
RUN chmod -R 755 projectsettings/static/pdf

# Execute startup scripts
RUN python manage.py collectstatic --noinput --settings=projectsettings.settings.docker_development_settings

RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]