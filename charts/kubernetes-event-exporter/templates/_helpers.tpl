{{/*
Expand the name of the chart.
*/}}
{{- define "kubernetes-event-exporter.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kubernetes-event-exporter.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kubernetes-event-exporter.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kubernetes-event-exporter.labels" -}}
helm.sh/chart: {{ include "kubernetes-event-exporter.chart" . }}
{{ include "kubernetes-event-exporter.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kubernetes-event-exporter.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kubernetes-event-exporter.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the namespace to use
Requires namespace to be set either in values.yaml or via -n flag
*/}}
{{- define "kubernetes-event-exporter.namespace" -}}
{{- if .Values.namespace }}
{{- .Values.namespace }}
{{- else if .Release.Namespace }}
{{- .Release.Namespace }}
{{- else }}
{{- fail "Namespace must be specified either in values.yaml (namespace: 'your-namespace') or via helm install -n your-namespace" }}
{{- end }}
{{- end }}

{{/*
Construct the full image reference
If digest is set, it overrides tag. Registry is prepended if specified.
*/}}
{{- define "kubernetes-event-exporter.image" -}}
{{- $registry := .Values.image.registry | default "" }}
{{- $repository := .Values.image.repository }}
{{- $tag := .Values.image.tag | default .Chart.AppVersion }}
{{- $digest := .Values.image.digest | default "" }}
{{- $image := $repository }}
{{- if $registry }}
{{- $image = printf "%s/%s" $registry $repository }}
{{- end }}
{{- if $digest }}
{{- printf "%s@%s" $image $digest }}
{{- else }}
{{- printf "%s:%s" $image $tag }}
{{- end }}
{{- end }}

{{/*
Generate a checksum of the config section to trigger pod restarts on ConfigMap changes
*/}}
{{- define "kubernetes-event-exporter.configChecksum" -}}
{{- include (print $.Template.BasePath "/configmap.yaml") . | sha256sum | trunc 8 }}
{{- end }}
