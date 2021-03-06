{{/*
Expand the name of the chart.
*/}}
{{- define "regenbogen-ice.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "regenbogen-ice.fullname" -}}
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
{{- define "regenbogen-ice.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "regenbogen-ice.labels" -}}
helm.sh/chart: {{ include "regenbogen-ice.chart" . }}
{{ include "regenbogen-ice.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "regenbogen-ice.selectorLabels" -}}
app.kubernetes.io/name: {{ include "regenbogen-ice.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Return true if a secet object should be created
*/}}
{{- define "regenbogen-ice.createSecret" -}}
{{- if not (or .Values.bot.existingSecret .Values.bot.sentry.existingSecret) -}}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Get the token secret.
*/}}
{{- define "regenbogen-ice.tokenSecretName" -}}
{{- if .Values.bot.existingSecret -}}
    {{- printf "%s" (tpl .Values.bot.existingSecret $) -}}
{{- else -}}
    {{- printf "%s" (include "regenbogen-ice.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Get the sentry dsn secret.
*/}}
{{- define "regenbogen-ice.sentrySecretName" -}}
{{- if .Values.bot.existingSecret -}}
    {{- printf "%s" (tpl .Values.bot.sentry.existingSecret $) -}}
{{- else -}}
    {{- printf "%s" (include "regenbogen-ice.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Get the token key.
*/}}
{{- define "regenbogen-ice.tokenSecretKey" -}}
{{- if .Values.bot.existingSecret -}}
    {{- printf "%s" (tpl .Values.bot.existingSecretKey $) -}}
{{- else -}}
    {{- "token" -}}
{{- end -}}
{{- end -}}

{{/*
Get the sentry dsn key.
*/}}
{{- define "regenbogen-ice.sentrySecretKey" -}}
{{- if .Values.bot.sentry.existingSecret -}}
    {{- printf "%s" (tpl .Values.bot.sentry.existingSecretKey $) -}}
{{- else -}}
    {{- "sentry_dsn" -}}
{{- end -}}
{{- end -}}
