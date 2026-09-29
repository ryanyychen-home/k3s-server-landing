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

GitHub Actions builds `site/` into an unprivileged nginx image and publishes it
to GitHub Container Registry. The workflow tags the image with the Git commit,
updates `k8s/deployment.yaml`, and commits that immutable version back to `main`.
Argo CD then reconciles the new Deployment image.

The package is published at:

```text
ghcr.io/ryanyychen-home/k3s-server-landing
```

The package must be public for anonymous image pulls. If it remains private,
configure an `imagePullSecret` in the `k3s-server-landing` namespace instead.

Render the manifests locally:

```sh
kubectl kustomize k8s
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
