# regenbogen-ice

Discord bot for tracking various german high speed trains.

## Installation

### Add Helm repository

```shell
helm repo add mikbot https://mikbot.github.io/charts
helm repo update
```

### Install chart

```shell
export DISCORD_TOKEN="your discord bot token"
helm install --generate-name \
    --namespace regenbogen-ice \
    --create-namespace \
    --set bot.token="$DISCORD_TOKEN" \
    mikbot/regenbogen-ice
```

**NOTE: You can also use an existing secret.
This is recommended for production use.**

## Sentry
Integration for [Sentry](https://sentry.io) can be configured via `bot.sentry.enabled` and `bot.sentry.dsn`.
