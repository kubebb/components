{{/*
Create a default fully qualified api app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "tmf.portal.fullname" -}}
{{- default .Chart.Name .Values.nameOverride }}
{{- end }}
{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "tmf.portal.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{/*
Api Common labels
*/}}
{{- define "tmf.portal.labels" -}}
app: {{ include "tmf.portal.fullname" . }}
helm.sh/chart: {{ include "tmf.portal.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Api Selector labels
*/}}
{{- define "tmf.portal.selectorLabels" -}}
app: {{ include "tmf.portal.fullname" . }}
{{- end }}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
refer: https://github.com/helm/charts/pull/15202
*/}}
{{- define "tmf.portal.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{- define "tmf.portal.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "tmf.portal.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}