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
        enabled: true
        backend: secret
        application-name: vault-secret
        default-context:
        profiles: ${spring.profiles.active}
      # 하위버전의 경우 v2를 사용하는 경우 generic을 disable
      generic:
        enabled: false
```

## policy, token 생성

```sh
# policy : secret-read-only
# Grants read access to everything under 'secret/'
$ vault policy write secret-read-only - << EOF
path "secret/data/*" {
  capabilities = ["read", "list"]
}
EOF
```

```sh
$ vault token create \
  -policy="secret-read-only" \
  -ttl=24h \
  -explicit-max-ttl=720h \
  -renewable=true
```

## Secret Backends(v2.1.x)

> https://cloud.spring.io/spring-cloud-vault/2.1.x/single/spring-cloud-vault.html#vault.config.backends
