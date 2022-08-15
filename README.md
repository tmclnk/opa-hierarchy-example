# OPA - Branch Hierarchy Security

This repository contains the `rego` and json data to
model all of the examples in the [abc branch security presentation](https://dmsi.sharepoint.com/:v:/r/development/Security%20Admin/Branch%20Hierarchy-Security%20project/Branch%20Hierarchy-Enhanced%20Security%20Overview.mp4?csf=1&web=1) (warning: video).

This repo does not demonstrate the use of `opa` as an agent or sidecar process. It does not
demonstrate any data syncing or API usage.

## Usage

You'll need to install opa v0.43.0 from [here](https://github.com/open-policy-agent/opa/releases/tag/v0.43.0).


## Eval

You can evaluate different expressions from the command line. 
We will pass two files in.

1. [input.json](input.json), which models data you pass to opa, e.g. username and branch. In practice, the input data may be a JWT, entitlements from ADFS, LDAP attributes, etc.
2. [data.json](data.json), which is data stored in the agent. This is data you would sync out to the agents. In this example, it includes
   - `user_data` - the user's roles and default branch
   - `org_chart_data` - a DAG of the org chart
   - `role_data` - roles, securable_objects, and the security_level for each level

You can modify the values in [input.json](input.json) to mimic different `current_branch` scenarios.


### Eval Examples
```shell
opa eval -b . -f pretty -d data.json -i input.json 'data.branch_hierarchy.effective_security_level'
```

Output:
```json
{
  "CM_ENTRY": "read_only",
  "PRINT_ACKNOWLEDGEMENTS": "full",
  "SO_ENTRY": "read_only"
}
```

### Other Examples

```shell
opa eval -b . -f pretty -d data.json -i input.json 'data.branch_hierarchy.effective_security_levels'
opa eval -b . -f pretty -d data.json -i input.json 'data.branch_hierarchy.effective_security_level.SO_ENTRY'
opa eval -b . -f pretty -d data.json -i input.json 'data.branch_hierarchy.effective_security_level.CM_ENTRY'
opa eval -b . -f pretty -d data.json -i input.json 'data.branch_hierarchy.effective_security_level["SO_ENTRY"]'
opa eval -b . -f pretty -d data.json -i input.json 'data.branch_hierarchy.user_permissions'
```


## Unit Tests

```
opa test . -v
```

## Terminology

I'm just listing these here. Each of these is a different thing.

- securable_object
- security_level (there are 4, roughly `full`,`read_only`,`limited`, and null). Null is a deliberate choice.
- level (in the hierarchy)
- role
- user

## Philosophy

We don't have an explicit `deny` as a value (at least, within the innards of the system - we could add a top-level default). 
This is because as we search the user's roles, we are looking for explicit permissions and accumulating
them as we go. One could read "deny" as an explicit override, rather than simply _not_ having the permission.

This is debatable, but it's what I did here.


## Related Links

- [OPA Policy Reference](https://www.openpolicyagent.org/docs/v0.43.0/policy-reference/)
- [OPA Policy Language](https://www.openpolicyagent.org/docs/v0.43.0/policy-language/)
