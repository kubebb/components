{{/*
Create a default fully qualified api app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "tmf.initializr.fullname" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- define "tmf.initializr.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{/*
Api Common labels
*/}}
{{- define "tmf.initializr.labels" -}}
app: {{ include "tmf.initializr.fullname" . }}
helm.sh/chart: {{ include "tmf.initializr.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Api Selector labels
*/}}
{{- define "tmf.initializr.selectorLabels" -}}
app: {{ include "tmf.initializr.fullname" . }}
{{- end }}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
refer: https://github.com/helm/charts/pull/15202
*/}}
{{- define "tmf.initializr.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{- define "tmf.initializr.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "tmf.initializr.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}