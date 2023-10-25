{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "apm.portal.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{/*
Create a default fully qualified api app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "apm.portal.fullname" -}}
{{- default .Chart.Name .Values.nameOverride }}
{{- end }}
{{/*
Api Common labels
*/}}
{{- define "apm.portal.labels" -}}
app: {{ include "apm.portal.fullname" . }}
helm.sh/chart: {{ include "apm.portal.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "apm.portal.menu.labels" -}}
helm.sh/chart: {{ include "apm.portal.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{/*
Api Selector labels
*/}}
{{- define "apm.portal.selectorLabels" -}}
name: {{ include "apm.portal.fullname" . }}
{{- end }}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
refer: https://github.com/helm/charts/pull/15202
*/}}
{{- define "apm.portal.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{- define "apm.portal.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "apm.portal.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}