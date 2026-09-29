FROM nginxinc/nginx-unprivileged:alpine

LABEL org.opencontainers.image.source="https://github.com/ryanyychen-home/k3s-server-landing"
LABEL org.opencontainers.image.description="Architecture landing page for the k3s-server homelab"

COPY --chown=101:101 site/ /usr/share/nginx/html/
