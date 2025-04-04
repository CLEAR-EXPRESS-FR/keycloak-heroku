# --- Dockerfile ---
FROM quay.io/keycloak/keycloak:24.0.2

ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

# 创建可写目录并复制脚本
USER root
RUN mkdir -p /opt/keycloak/scripts
COPY parse-heroku-env.sh /opt/keycloak/scripts/
RUN chmod +x /opt/keycloak/scripts/parse-heroku-env.sh

# 执行 build
RUN /opt/keycloak/bin/kc.sh build

# 切换为默认用户
USER 1000

EXPOSE 8080

# 启动前先解析 Heroku 环境变量
ENTRYPOINT ["/opt/keycloak/scripts/parse-heroku-env.sh"]

# 启动 Keycloak
CMD ["/opt/keycloak/bin/kc.sh", "start", "--proxy=edge", "--hostname-strict=false", "--http-port=${PORT}"]
