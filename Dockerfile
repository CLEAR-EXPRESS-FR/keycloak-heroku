FROM quay.io/keycloak/keycloak:24.0.2

# 构建 Keycloak 配置（必须）
RUN /opt/keycloak/bin/kc.sh build

# 启动 Keycloak，开放 0.0.0.0 给 Heroku，用 edge 代理兼容 Heroku 路由
CMD ["sh", "-c", "/opt/keycloak/bin/kc.sh start --proxy=edge --hostname-strict=false --http-port=$PORT"]
