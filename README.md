# OuluOpenHack API

Teams can register to OuluOpenHack via this API.

API is running on https://api.ouluopenhack.org

## API documentation

```POST /v1/teams```

### Payload

```
{
  name: "TEAM NAME",
  users: [
    { email: "first team member email", name: "first team member name" },
    ...
    ...
    { email: "last team member email", name: "last team member name" },
  ]
}
```


## Installation

run ```rails test``` to run tests.

Development environment uses ```mailcatcher``` gem for receiving all emails. If you don't have it, install it by running ```gem install mailcatcher``` and run it


