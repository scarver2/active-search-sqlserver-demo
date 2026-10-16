# docker/sqlserver/Dockerfile
FROM ubuntu:22.04 AS full_text_search

RUN set -eux; \
    export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    apt-get install -y --no-install-recommends ca-certificates curl gnupg; \
    mkdir -p /usr/share/keyrings; \
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /usr/share/keyrings/microsoft.gpg; \
    curl -fsSL https://packages.microsoft.com/config/ubuntu/22.04/mssql-server-2022.list -o /etc/apt/sources.list.d/mssql-server.list; \
    sed -i 's|^deb \[|deb [signed-by=/usr/share/keyrings/microsoft.gpg |' /etc/apt/sources.list.d/mssql-server.list; \
    apt-get update; \
    cd /tmp; \
    apt-get download mssql-server-fts; \
    dpkg-deb --extract mssql-server-fts_*.deb /full_text_search

FROM mcr.microsoft.com/mssql/server:2022-latest

ENV ACCEPT_EULA=Y

USER root

COPY --from=full_text_search /full_text_search/ /

USER mssql

EXPOSE 1433
