# ============================================================
# Ministère de la Communication du Sénégal — New Deal Technologique
# Intranet MinComSN — Image Docker
# Base : nginx:alpine3.23 (légère, sécurisée)
# ============================================================

FROM nginx:alpine3.23

# Métadonnées
LABEL maintainer="DevOps MinComSN <devops@communication.gouv.sn>"
LABEL description="Intranet Ministère de la Communication - New Deal Technologique"
LABEL version="1.0"

# Copie des fichiers statiques dans la racine Nginx
COPY index.html    /usr/share/nginx/html/
COPY landing.html  /usr/share/nginx/html/
COPY generic.html  /usr/share/nginx/html/
COPY elements.html /usr/share/nginx/html/
COPY assets/       /usr/share/nginx/html/assets/
COPY images/       /usr/share/nginx/html/images/

# Configuration Nginx personnalisée
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Permissions minimales (sécurité)
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html

# Port HTTP
EXPOSE 80

# Healthcheck intégré
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD wget -q --spider http://localhost/ || exit 1

# Démarrage Nginx au premier plan
CMD ["nginx", "-g", "daemon off;"]
