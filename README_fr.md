# code-server pour YunoHost

[![Niveau d'intégration](https://dash.yunohost.org/integration/code-server.svg)](https://dash.yunohost.org/appci/app/code-server) ![](https://ci-apps.yunohost.org/ci/badges/code-server.status.svg) ![](https://ci-apps.yunohost.org/ci/badges/code-server.maintain.svg)  
[![Installer code-server avec YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=code-server)

*[Read this readme in english.](./README.md)*
*[Lire ce readme en français.](./README_fr.md)*

> *Ce package vous permet d'installer code-server rapidement et simplement sur un serveur YunoHost.
Si vous n'avez pas YunoHost, regardez [ici](https://yunohost.org/#/install) pour savoir comment l'installer et en profiter.*

## Vue d'ensemble

Lancez VS Code sur votre serveur et accédez-y depuis votre navigateur

**Version incluse :** 3.10.2~ynh2



## Captures d'écran

![](./doc/screenshots/screenshot.png)

## Avertissements / informations importantes

### Limitations

* Nécessite un domaine dédié
* Un seul utilisateur seulement, pas de LDAP
* Les sous-domaines pour les services sur les ports (like 8080.code-server-domain.tld) ne sont pas pris en charge

### Other info

* Le paquet ne crée pas d'utilisateur système dédié; on vous demandera pendant l'installation quel utilisateur vous voulez que cod-serveur éxecute en tant que. **Ne donnez pas accès à des utilisateurs en lesquels vous n'avez pas complètement confiance !**
* Vous pouvez demander un mot de passe pour accéder à code-server (facultatif). **Ne laissez pas le champ mot-de-passe vide si vous avez permis l'accès public !**

## Documentations et ressources

* Site officiel de l'app : https://github.com/cdr/code-server
* Documentation officielle utilisateur : https://github.com/cdr/code-server/tree/main/docs
* Documentation officielle de l'admin : https://github.com/cdr/code-server/tree/main/docs
* Dépôt de code officiel de l'app : https://github.com/cdr/code-server
* Documentation YunoHost pour cette app : https://yunohost.org/app_code-server
* Signaler un bug : https://github.com/YunoHost-Apps/code-server_ynh/issues

## Informations pour les développeurs

Merci de faire vos pull request sur la [branche testing](https://github.com/YunoHost-Apps/code-server_ynh/tree/testing).

Pour essayer la branche testing, procédez comme suit.
```
sudo yunohost app install https://github.com/YunoHost-Apps/code-server_ynh/tree/testing --debug
ou
sudo yunohost app upgrade code-server -u https://github.com/YunoHost-Apps/code-server_ynh/tree/testing --debug
```

**Plus d'infos sur le packaging d'applications :** https://yunohost.org/packaging_apps