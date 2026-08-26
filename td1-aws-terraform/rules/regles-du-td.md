# Règles du TD 1 — non négociables

1. **Préfixe** : toute ressource nommée est préfixée par la variable `prenom` (`adrien-vpc`, `adrien-eks`...). Le compte AWS est partagé entre participants.
2. **Tags obligatoires** sur toute ressource taggable : `app = "semishop"`, `env = "td"`, `owner = var.prenom`, `team = "formation"`.
3. **Région imposée** : `eu-west-3`. Aucune ressource ailleurs.
4. **Versions épinglées** : Terraform `>= 1.12.0`, provider AWS `~> 6.61`, EKS `1.36`. On ne prend pas « la version que propose l'assistant » sans la vérifier.
5. **Zéro secret dans le code** : pas de clé d'accès, pas de mot de passe dans un `.tf`, un `.tfvars` versionné ou un prompt. Les identifiants vivent dans `aws configure` (profil), point.
6. **`terraform plan` avant tout `apply`** — et on **lit** le plan (compteur `to add/change/destroy`).
7. **Modèle économique** : `t3.small`, pas de NAT Gateway, pas de ressource hors cahier des charges.
8. **Destruction en fin de journée** : `terraform destroy` + vérification console. Une infra oubliée coûte toute la nuit.
