# FROM python:3.11.1-alpine3.17
FROM python:3.12-alpine
# FROM python:3.12

# ENV PYTHONUNBUFFERED 1
ENV PYTHONUNBUFFERED=1

COPY ./requirements.txt /requirements.txt

RUN apk add --update --no-cache postgresql-client build-base postgresql-dev

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /requirements.txt

COPY ./scripts /scripts
RUN chmod -R +x /scripts

ENV PATH="/scripts:/py/bin:$PATH"

COPY ./app /app
WORKDIR /app

EXPOSE 80
CMD ["/scripts/run.sh"]