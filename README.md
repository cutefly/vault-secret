# Vault secret on spring boot

> https://beaniejoy.tistory.com/102

## configuration

```groovy
ependencies {
	implementation 'org.springframework.cloud:spring-cloud-starter-vault-config'
}
```

```yaml
spring:
  config:
      import:
        - vault://
  cloud:
    vault:
      uri: https://vault.club012.com # vault domain uri (port: 8200)
      authentication: TOKEN
      token: ${VAULT_AUTH_TOKEN} # vault auth token
      connection-timeout: 3000
      read-timeout: 10000
      kv:
        backend: secret
        application-name: vault-secret
        default-context:
        profiles: ${spring.profiles.active}
```

## policy, token 생성

```hcl
# policy : secret-read-only
# Grants read access to everything under 'secret/'
path "secret/data/*" {
  capabilities = ["read", "list"]
}
```

```sh
$ vault token create \
  -policy="secret-read-only" \
  -ttl=24h \
  -explicit-max-ttl=720h \
  -renewable=true
```
