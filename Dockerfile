FROM python:3.10

# Update package list and install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    tar \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

# Install dependencies
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r requirements.txt

# Install FOP 2.9
RUN wget -nv https://storage.googleapis.com/server8koalixnet_backup/fop-2.9-bin.tar.gz
RUN tar -xzf fop-2.9-bin.tar.gz -C /usr/bin
RUN rm fop-2.9-bin.tar.gz
RUN chmod 755 /usr/bin/fop-2.9/fop/fop

# Install Java 8
RUN wget -nv https://storage.googleapis.com/server8koalixnet_backup/jdk-8u181-linux-x64.tar.gz
RUN tar -xzf jdk-8u181-linux-x64.tar.gz -C /usr/bin
RUN rm jdk-8u181-linux-x64.tar.gz

# Port to expose
EXPOSE 8000

# Command to run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]