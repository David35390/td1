# Prompt étape 7 — faire expliquer un échec de CI (avant de corriger)

À utiliser chaque fois qu'un run GitHub Actions est rouge et que la cause ne vous saute pas aux yeux — y compris pendant l'échec volontaire de l'étape 7. La règle du TD s'applique aussi au diagnostic : l'assistant explique la cause **avant** de proposer une correction.

Récupérez d'abord le log : sur la page du run rouge, cliquez sur le job `controle`, dépliez l'étape marquée d'une croix, sélectionnez les ~30 dernières lignes et copiez-les.

```text
Tu assistes un debutant en Terraform et GitHub Actions.

Contexte : mon depot GitHub contient un projet Terraform (dossier
terraform/) et un workflow terraform-ci.yml qui enchaine :
terraform fmt -check -recursive, terraform init -backend=false,
terraform validate, puis un scan trivy config (severites
HIGH/CRITICAL bloquantes, ignores justifies dans .trivyignore).
Le dernier run est ROUGE. Je colle plus bas le log de l'etape en
echec.

Ta tache, dans CET ordre :
1. Identifie l'etape qui a echoue et cite la ligne exacte du log
   qui le prouve.
2. Explique la CAUSE en francais simple (2 phrases max), sans
   encore proposer de correction.
3. Explique pourquoi ce controle existe : qu'est-ce qui serait
   arrive plus tard sans lui ?
4. Seulement ensuite : propose la correction minimale, et la
   commande locale qui me permet de verifier AVANT de pousser.

Contraintes :
- Ne me propose jamais de desactiver le controle (allow_failure,
  suppression de l'etape, exit-code 0) : la correction porte sur
  le code, pas sur le controleur.
- Si le log ne suffit pas pour trancher, dis-le et liste ce qui
  te manque.

[collez ici les ~30 dernieres lignes du log de l'etape rouge]
```

**Ce que vous devez retrouver dans la réponse** :

- La ligne fautive **citée depuis votre log** (pas paraphrasée) et le nom de l'étape en échec — sinon l'assistant a répondu de mémoire, pas d'après vos données.
- Une cause en français simple avant toute correction, puis la commande **locale** de contre-vérification (`terraform fmt -check -recursive`, `terraform validate`...) à lancer avant de repousser.
- Aucune proposition de désactivation du contrôle ; si la réponse suggère `allow_failure` ou de retirer l'étape, refusez-la et rappelez la contrainte.
