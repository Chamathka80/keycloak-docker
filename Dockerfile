FROM quay.io/keycloak/keycloak:latest as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure a database vendor
ENV KC_DB=postgres

WORKDIR /opt/keycloak
# for demonstration purposes only, please make sure to use proper certificates in production instead
RUN keytool -genkeypair -storepass Vizua@123 -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=IP:124.43.162.91" -keystore conf/server.keystore
RUN /opt/keycloak/bin/kc.sh build


# change these values to point to a running postgres instance
ENV KC_DB_URL=postgres://postgres:e5e57db939b9b5e3b3cc80bcf1186fe0@dokku-postgres-keycloakdb-latest:5432/keycloakdb_latest
ENTRYPOINT ["/opt/keycloak/bin/kc.sh start-dev"]
