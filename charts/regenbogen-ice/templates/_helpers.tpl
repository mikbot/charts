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
Define the token secret name
*/}}
{{- define "regenbogen-ice.tokenSecret" -}}
{{- if not .Values.bot.token}}
{{- required "bot.existingSecret must be set when no token is defined." .Values.bot.existingSecret | trunc 63 }}
{{- else }}
{{- .Release.Name }}-secret
{{- end }}
{{- end }}

{{/*
Define the token secret key
*/}}
{{- define "regenbogen-ice.tokenSecretKey" -}}
{{- if not .Values.bot.token}}
{{- required "bot.existingSecretKey must be set when no token is defined." .Values.bot.existingSecretKey }}
{{- else }}
{{- print "token" }}
{{- end }}
{{- end }}

{{/*
Define the sentry secret name
*/}}
{{- define "regenbogen-ice.sentrySecret" -}}
{{- if not .Values.bot.sentry.dsn -}}
{{- required "bot.sentry.existingSecret must be set when no dsn is defined." .Values.bot.existingSecret | trunc 63 }}
{{- else }}
{{- .Release.Name }}-secret
{{- end }}
{{- end }}

{{/*
Define the sentry dsn secret key
*/}}
{{- define "regenbogen-ice.sentrySecretKey"}}
{{- if not .Values.bot.sentry.dsn -}}
{{- required "bot.sentry.existingSecretKey must be set when no dsn is defined" .Values.bot.sentry.existingSecretKey }}
{{- else }}
{{- print "sentry_dsn"}}
{{- end }}
{{- end }}
