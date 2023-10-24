{{/*
Create a default fully qualified api app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "apm.operator.fullname" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- define "apm.operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{/*
Api Common labels
*/}}
{{- define "apm.operator.labels" -}}
k8s-app: {{ include "apm.operator.fullname" . }}
app: {{ include "apm.operator.fullname" . }}
helm.sh/chart: {{ include "apm.operator.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Api Selector labels
*/}}
{{- define "apm.operator.selectorLabels" -}}
name: {{ include "apm.operator.fullname" . }}
{{- end }}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
refer: https://github.com/helm/charts/pull/15202
*/}}
{{- define "apm.operator.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}