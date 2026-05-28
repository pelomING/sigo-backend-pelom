# Filename: Dockerfile

FROM alpine:latest

WORKDIR /tmp

RUN apk update && apk add \
    tzdata \
    git \
    python3 \
    py3-pip \
    py3-virtualenv \
    python3-dev

WORKDIR /usr/local/share/api
COPY requirements.txt .
COPY app.py .
RUN virtualenv .venv
RUN . .venv/bin/activate && pip install -r requirements.txt


# CMD ["./run-api.sh"]
CMD [".venv/bin/gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
