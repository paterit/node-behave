FROM node:15.1-alpine

# Python support added based on:
#https://github.com/frol/docker-alpine-python3/blob/master/Dockerfile

# These are always installed. Notes:
#   * dumb-init: a proper init system for containers, to reap zombie children
#   * bash: For entrypoint, and debugging
#   * ca-certificates: for SSL verification during Pip and easy_install
#   * python: the binaries themselves

RUN apk update && \
    apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

# make some useful symlinks that are expected to exist
RUN if [[ ! -e /usr/bin/python ]];        then ln -sf /usr/bin/python3 /usr/bin/python; fi \
    && if [[ ! -e /usr/bin/python-config ]]; then ln -sf /usr/bin/python-config3 /usr/bin/python-config; fi \
    && if [[ ! -e /usr/bin/idle ]];          then ln -sf /usr/bin/idle3 /usr/bin/idle; fi \
    && if [[ ! -e /usr/bin/pydoc ]];         then ln -sf /usr/bin/pydoc3 /usr/bin/pydoc; fi \
    && if [[ ! -e /usr/bin/easy_install ]];  then ln -sf $(ls /usr/bin/easy_install*) /usr/bin/easy_install; fi \
    && echo

RUN apk update && \
    apk add --no-cache \
    dumb-init \
    bash \
    ca-certificates \
    chromium \
    chromium-chromedriver

WORKDIR /paterit/node-behave-alpine
COPY requirements.txt .

RUN pip install -U pip \
    && pip install -r requirements.txt

COPY . .

# in the entrypoint.sh simple http server will be started with this port
ENV DUMMY_HTTP_SERVER_PORT 8888

RUN chmod +x entrypoint.sh

CMD ["/paterit/node-behave-alpine/entrypoint.sh"]

# example usage
# docker run -it paterit/node-behave-alpine
