{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "apm.api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{/*
Create a default fully qualified api app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "apm.api.fullname" -}}
{{- default .Chart.Name .Values.nameOverride }}
{{- end }}

{{/*
Api Common labels
*/}}
{{- define "apm.api.labels" -}}
app: {{ include "apm.api.fullname" . }}
helm.sh/chart: {{ include "apm.api.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Api Selector labels
*/}}
{{- define "apm.api.selectorLabels" -}}
app: {{ include "apm.api.fullname" . }}
{{- end }}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
refer: https://github.com/helm/charts/pull/15202
*/}}
{{- define "apm.api.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}