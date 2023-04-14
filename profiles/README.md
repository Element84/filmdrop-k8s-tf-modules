# Profiles

Profiles is a concept from [Puppet](https://www.puppet.com/docs/puppet/7/the_roles_and_profiles_method.html), in our case they intend to be templates combinining multiple modules that configure an environment stack.

At the moment we have the following profiles:

- [Core](./core/) containing all the modules needed to stand up a filmdrop deployment within an existing kubernetes cluster

## How to create a Profile

To create a profile, create a directory under ```./profiles```. The directory should contain the follwing:
- ```inputs.tf``` - File to specify input variables
- ```profile.tf``` - Grouping of Terraform modules from the ```./modules``` directory.
- ```providers.tf``` - Terraform providers for the profile.
- ```output.tf``` - (Optional) File to specify profile outputs. Only required if there are actual outputs to export from the profile.
