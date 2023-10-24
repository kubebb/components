{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "tmf.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified api app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "api.fullname" -}}
{{- default .Chart.Name .Values.nameOverride }}
{{- end }}

{{/*
Api Common labels
*/}}
{{- define "api.labels" -}}
app: {{ include "api.fullname" . }}
helm.sh/chart: {{ include "tmf.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Api Selector labels
*/}}
{{- define "api.selectorLabels" -}}
name: {{ include "api.fullname" . }}
{{- end }}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
refer: https://github.com/helm/charts/pull/15202
*/}}
{{- define "api.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}