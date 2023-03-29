# Grafana and Prometheus

This module installs two resources:

- [Grafana](https://grafana.com/grafana/) for visualization and dashboards.
- [Prometheus](https://grafana.com/oss/prometheus/) for metric monitoring.

## Installation

1. First, initialize terraform:

```bash
terraform init
```

2. Validate that the terraform resources are valid. If your terraform is valid the validate command will respond with _"Success! The configuration is valid."_

```bash
terraform validate
```

3. Run a terraform plan. The terraform plan will give you a summary of all the changes terraform will perform prior to deploying any change.

```bash
terraform plan
```

4. Deploy the changes by applying the terraform plan. You will be asked to confirm the changes and must respond with _"yes"_.

```bash
terraform apply
```
