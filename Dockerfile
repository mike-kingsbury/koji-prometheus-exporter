FROM fedora:latest

LABEL maintainer="Ralph Bean" \
      summary="A prometheus exporter for koji." \
      distribution-scope="public"

RUN dnf install -y --setopt=tsflags=nodocs \
                python3-koji \
                python3-prometheus_client \
    && dnf clean all

# Allow a non-root user to install a custom root CA at run-time
RUN chmod g+w /etc/pki/tls/certs/ca-bundle.crt

COPY koji-prometheus-exporter.py /usr/local/bin/.
COPY docker/ /docker/

USER 1001
EXPOSE 8080
ENTRYPOINT ["/docker/entrypoint.sh"]