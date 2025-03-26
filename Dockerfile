FROM quay.io/keycloak/keycloak:24.0.2

RUN /opt/keycloak/bin/kc.sh build

EXPOSE 8080

CMD ["/opt/keycloak/bin/kc.sh", "start", "--proxy=edge", "--hostname-strict=false", "--http-port=${PORT}"]
