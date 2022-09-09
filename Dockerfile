FROM python:3.8-slim

WORKDIR /opt/src

COPY requirements.txt requirements.txt

RUN pip3 install --no-cache-dir --user -r requirements.txt

COPY . .
