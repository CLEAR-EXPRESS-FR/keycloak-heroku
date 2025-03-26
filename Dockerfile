FROM quay.io/keycloak/keycloak:24.0.2

ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

# === 🔁 将 Heroku 的 DATABASE_URL 拆解为 Keycloak 环境变量 ===
COPY parse-heroku-env.sh /opt/keycloak/parse-heroku-env.sh
RUN chmod +x /opt/keycloak/parse-heroku-env.sh && /opt/keycloak/parse-heroku-env.sh

# === ⚙️ 构建 Keycloak 配置 ===
RUN /opt/keycloak/bin/kc.sh build

# === ✅ 启动 Keycloak 使用 Heroku 推荐参数 ===
CMD ["start", "--proxy=edge", "--hostname-strict=false", "--http-port=${PORT}"]
