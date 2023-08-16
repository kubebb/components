{{- define "rating-name" -}}
{{- printf "%s.%s-rating" .Release.Namespace .Release.Name -}}
{{- end -}}
