FROM python:3.10

WORKDIR /usr/src/app

# Install dependencies
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r requirements.txt

# Install FOP 2.9
RUN wget https://storage.googleapis.com/server8koalixnet_backup/fop-2.9-bin.tar.gz
RUN tar -xzf fop-2.9-bin.tar.gz -C ../usr/bin
RUN rm -rf fop-2.9-bin.tar.gz
RUN chmod 755 /usr/bin/fop-2.9/fop/fop

# Install Java 8
RUN wget https://storage.googleapis.com/server8koalixnet_backup/jdk-8u181-linux-x64.tar.gz
RUN tar -xzf jdk-8u181-linux-x64.tar.gz -C ../usr/bin
RUN rm -rf jdk-8u181-linux-x64.tar.gz


# Port to expose
EXPOSE 8000

# Command to run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]