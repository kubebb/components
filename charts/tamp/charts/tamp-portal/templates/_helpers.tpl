{{/*
Expand the name of the chart.
*/}}
{{- define "tamp-portal.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "tamp-portal.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "tamp-portal.labels" -}}
helm.sh/chart: {{ include "tamp-portal.chart" . }}
{{ include "tamp-portal.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "tamp-portal.selectorLabels" -}}
app.kubernetes.io/name: {{ include "tamp-portal.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}