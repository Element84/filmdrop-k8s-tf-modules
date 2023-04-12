# Tiling

This module installs resources that render and serve tiles. Currently it only installs the basic configuration of [Titiler](https://github.com/developmentseed/titiler).

**Currently Titiler does not distribute a docker image for an ARM architecture. If you're running an Apple silicon (M1, M2) or similar laptop you should skip installation of the tiling namespace.**

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

Once installed you can verify Titiler is running by first configuring port forwarding from the Titiler pod:

```bash
kubectl port-forward {TITILER_POD_NAME} 3000:80
```

Then with your browser of choice navigate to `http://localhost:3000`.
