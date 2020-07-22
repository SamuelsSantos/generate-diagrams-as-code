FROM python:3.8-slim-buster as diagram-as-action

LABEL maintainer_1="https://github.com/SamuelsSantos"
LABEL Project="https://github.com/SamuelsSantos/generate-diagrams-as-code.git"

RUN mkdir -p /data
WORKDIR /data

ENV DIAGRAM_FILE=

## Install graphviz "Uses Graphviz to render images"
RUN apt-get update -y
RUN apt-get install -y graphviz

COPY requirements.txt /data
RUN pip install -r requirements.txt
VOLUME [ "/data" ]

# https://help.github.com/en/actions/creating-actions/dockerfile-support-for-github-actions#user
USER root

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]