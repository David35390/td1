# Journal de bord — TD 1

Une ligne par événement marquant : erreur rencontrée, décision prise, commande qui a sauvé la situation. C'est la moitié de votre rendu final — « ça a marché » ne s'y écrit pas, « voilà pourquoi ça a marché » oui.

| Heure | Étape | Ce qui s'est passé (erreur, décision, astuce) | Ce que j'en retiens |
|-------|-------|-----------------------------------------------|---------------------|
| 14:27 | 4 - IAM | Les rôles IAM du cluster et des nœuds ont été ajoutés à la configuration. | EKS et ses nœuds ont besoin de rôles distincts, avec les permissions adaptées à chacun. |
| 15:04 | 6 - Connexion | L'étape de connexion à EKS a été préparée dans le projet. | La création du cluster ne suffit pas : il faut ensuite récupérer les identifiants et tester l'accès avec `kubectl`. |
| 15:19 | 7 - CI | Le workflow GitHub Actions a été ajouté pour contrôler automatiquement le format et la configuration Terraform. | La CI est un contrôle reproductible ; elle doit être relue dans l'onglet Actions, pas seulement supposée verte après un `git push`. |
| 15:57 | 3 à 5 - Terraform | Le réseau, IAM, EKS et les outputs ont été réunis dans la configuration du projet. | Les ressources sont liées entre elles par leurs références Terraform ; il faut lire le plan avant tout `apply`. |
| 16:16 | 7 - Échec CI | Un espace ajouté volontairement devant `cidr_block` a cassé le formatage. `tofu fmt -check -recursive` signale `terraform/network.tf` et renvoie le code 1, alors que la syntaxe HCL reste valide. | Une configuration peut être valide tout en étant refusée par le formatage. La cause est l'indentation, pas le réseau AWS ; le correctif est `tofu fmt` puis un nouveau contrôle. |
| 16:24-16:31 | PR et tags | Le tag `costcenter = "poc-td1"` a été ajouté dans `providers.tf` sur une branche dédiée, puis fusionné par pull request. | Une branche et une revue rendent le changement traçable ; les tags servent aussi au suivi des coûts dans un compte AWS partagé. |

## Points à résoudre

- [ ] Corriger l'indentation de `cidr_block` dans `terraform/network.tf`, puis relancer `tofu fmt -check -recursive` jusqu'à obtenir un code retour 0.
- [ ] Relancer les contrôles depuis le bon répertoire : `tofu -chdir=terraform validate` et `tofu -chdir=terraform plan`, puis lire le compteur `to add/change/destroy` avant toute création.
- [ ] Vérifier dans AWS et avec `tofu -chdir=terraform state list` si l'infrastructure a réellement été créée. L'état local ne liste actuellement aucune ressource, donc un `apply` réussi n'est pas attesté dans ce journal.
- [ ] En fin de journée, détruire l'infrastructure éventuellement présente et vérifier dans la console AWS qu'aucune ressource du participant ne reste facturée.

## Écarts vers la production

À remplir à l'étape 8 (la liste guidée est dans le README) : ce que ce PoC assume et qu'une production ne pourrait pas assumer.

| Écart assumé dans le PoC | Ce qu'on ferait en production |
|--------------------------|-------------------------------|
|                          |                               |
|                          |                               |
|                          |                               |
|                          |                               |
