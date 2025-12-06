# kubernetes-event-exporter

> **Note:** This is an active fork of [Resmo Kubernetes Event Exporter](https://github.com/resmoio/kubernetes-event-exporter).  
> This fork **only adds Helm chart support** for easier Kubernetes deployment and does not otherwise change the original functionality.

> ⚠️ **Important:** The [Bitnami Kubernetes Event Exporter chart](https://github.com/bitnami/charts/tree/main/bitnami/kubernetes-event-exporter) has introduced breaking changes that may cause unexpected behavior.  
> This fork provides a Helm chart that stays consistent with the original Resmo exporter while fixing these issues.

This tool allows exporting the often missed Kubernetes events to various outputs so that they can be used for
observability or alerting purposes.

## Helm Deployment

Add the Helm repo:

```bash
helm repo add itakurah https://itakurah.github.io/kubernetes-event-exporter/
helm repo update
```
Install or upgrade the chart:
```
helm upgrade --install kubernetes-event-exporter itakurah/kubernetes-event-exporter \
  --namespace <name>
```
To customize configuration, create a `values.yaml` file and run:
```
helm upgrade --install kubernetes-event-exporter itakurah/kubernetes-event-exporter \
  --namespace <name> \
  -f values.yaml
```

For full configuration details, see the original [Resmo Kubernetes Event Exporter documentation](https://github.com/resmoio/kubernetes-event-exporter#configuration)
.

## Original Project

This fork is derived from [Resmo Kubernetes Event Exporter](https://github.com/resmoio/kubernetes-event-exporter).

All runtime behavior, event routing, and receiver configuration are as documented in the original project.
