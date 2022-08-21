### Installation

* Le paquet ne crée pas d'utilisateur système dédié; on vous demandera pendant l'installation quel utilisateur vous voulez que code-serveur éxecute en tant que. **Ne donnez pas accès à des utilisateurs en lesquels vous n'avez pas complètement confiance !**

### Limitations

* Nécessite un domaine dédié
* `code-server` s'éxécute avec l'utilisateur choisir lors de l'installation
* Les fichiers de `code-server` sont stockés dans `/home/<votre-utilisateur>/.local/share/code-server`
* Les sous-domaines pour les services sur les ports (like 8080.code-server-domain.tld) ne sont pas pris en charge

### Extensions

Cette application utilie le [catalogue Open VSX](https://open-vsx.org/). Vous pouvez changer ce paramètre depuis le panneau de configuration.

Voir https://coder.com/docs/code-server/latest/FAQ#how-do-i-use-my-own-extensions-marketplace *(en anglais)*
