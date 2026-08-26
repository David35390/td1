# Prompt étape 2 — faire expliquer le squelette (pas le générer)

Premier réflexe à installer : avant de demander du code à un assistant, on lui fait **expliquer** le code qu'on a déjà. Collez le prompt ci-dessous, puis collez à la suite le contenu de `versions.tf`, `providers.tf` et `variables.tf`.

```text
Tu assistes un debutant complet en Terraform (premier jour).

Contexte : je monte un PoC AWS (VPC + EKS) avec Terraform, dans un
compte AWS partage entre participants d'une formation, region
eu-west-3. Le squelette du projet m'est fourni ; je colle plus bas
trois fichiers : versions.tf, providers.tf, variables.tf.

Ta tache : explique-moi ces trois fichiers, bloc par bloc, dans
l'ordre ou je les ai colles. Pour chaque bloc : ce qu'il declare,
ce qui se passerait s'il etait absent, et une erreur classique de
debutant associee.

Contraintes :
- Ne genere AUCUN code nouveau, ne reecris pas les fichiers.
- Ne propose aucune "amelioration" : je veux comprendre l'existant.
- Explique les notations ">= 1.12.0" et "~> 6.61" avec un exemple
  de version acceptee et une refusee pour chacune.
- Explique ce que default_tags va produire concretement sur une
  ressource creee.

Format : une section par fichier, phrases courtes, pas de jargon
non defini.

[collez ici versions.tf, puis providers.tf, puis variables.tf]
```

**Ce que vous devez retrouver dans la réponse** :

- La différence entre `>= 1.12.0` (plancher) et `~> 6.61` (mineures acceptées, majeure bloquée), chacune avec un exemple chiffré.
- Le rôle du provider AWS (traduire le HCL en appels d'API) et l'effet concret de `default_tags` : vos 4 tags posés sur chaque ressource sans les réécrire.
- Le rôle de la `validation` de `var.prenom` : refuser majuscules et accents **avant** de toucher à AWS.

🟨 Si la réponse propose du code ou des « améliorations » : c'est le prompt qui a été tronqué au collage — recollez-le en entier, la contrainte « ne génère aucun code » en fait partie.
