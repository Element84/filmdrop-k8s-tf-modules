# Profiles

Profiles is a concept from [Puppet](https://www.puppet.com/docs/puppet/7/the_roles_and_profiles_method.html), in our case they intend to be templates combinining multiple modules that configure an environment stack.

At the moment we have the following profiles:

- [Core](./core/) containing all the modules needed to stand up a filmdrop deployment within an existing kubernetes cluster
