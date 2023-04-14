# Service Mesh

This module defines different options for running a service mesh. This includes:

- [Linkerd](https://linkerd.io/) lightweight service mesh for kubernetes created by Buoyant.

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

<sub><sup>Instructions for installing individual monitoring services can be found in their specific README files.</sup></sub>
