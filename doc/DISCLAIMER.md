### Limitations

* Requires a dedicated domain
* Single-user, no LDAP
* Subdomains for services on ports (like 8080.code-server-domain.tld) are not supported

### Other info

* The package does not create a dedicated system user, rather during installation you are asked what user you want code-server to run as. **Don't give access to users you don't fully trust!**
* You can optionally set a password required to access code-server. **Don't leave this blank if you have allowed public access!**
