### Installation

* The package does not create a dedicated system user, rather during installation you are asked what user you want code-server to run as. **Don't give access to users you don't fully trust!**

### Limitations

* Requires a dedicated domain
* Single-user, no LDAP
* Subdomains for services on ports (like 8080.code-server-domain.tld) are not supported

### Extensions

This application uses [Open VSX Registry](https://open-vsx.org/). You can change this setting from the web admin config panel.

See https://coder.com/docs/code-server/latest/FAQ#how-do-i-use-my-own-extensions-marketplace
