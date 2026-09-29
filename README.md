# k3s-server-landing

Internal landing page for the personal K3s homelab. The site documents the
architecture and GitOps delivery workflow without exposing cluster credentials,
addresses, or administrative endpoints.

## Local preview

Serve `site/` as the document root:

```sh
python3 -m http.server 8080 --directory site
```

Then visit <http://localhost:8080/>.

## Kubernetes deployment

The root Kustomization generates a versioned ConfigMap from `site/` and mounts it
into an unprivileged nginx Deployment. A site change therefore changes the
generated ConfigMap name and triggers a rollout without building a custom image.

Render the manifests locally:

```sh
kubectl kustomize .
```

Argo CD deploys the repository into the `k3s-server-landing` namespace. The
internal Traefik hostname is `landing.home.arpa`.

Add an internal DNS or hosts-file entry pointing the hostname to the K3s node's
reachable LAN or Tailscale address. Do not commit machine-specific addresses to
this repository.

## Future public hostname

When a public domain and secure ingress path are available, replace the hostname
in `k8s/ingress.yaml` and add TLS configuration. Keep Kubernetes, SSH, Argo CD,
and other administrative endpoints private.
