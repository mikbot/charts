## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

    helm repo add mikbot https://mikbot.github.io/charts

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
mikbot` to see the charts.

## Example: [regenbogen-ice](https://github.com/mikbot/regenbogen-ice)

To install the regenbogen-ice chart:

    helm install my-regenbogen-ice mikbot/regenbogen-ice

To uninstall the chart:

    helm delete my-regenbogen-ice
