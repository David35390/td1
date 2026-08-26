---
titre: "TD 1 - Cahier des charges - infrastructure PoC SemiShop"
version: "1.0.0"
date_maj: "2026-08-25"
formation: "IA & Infra/DevOps : industrialiser l'IA dans CI/CD, IaC, Kubernetes, GitOps et les operations"
auteur: "Adrien Vossough"
---

# Cahier des charges — infrastructure PoC SemiShop

🟤 **Contexte client**. SemiShop (e-commerce, ~120 personnes) déploie aujourd'hui ses microservices à la main sur des machines virtuelles. La direction technique veut valider Kubernetes managé sur AWS **avant** le pic des soldes. Adrien Vossough, responsable plateforme, cadre un PoC : petit, reproductible, jetable. Guive Voss, ops, exige que rien ne soit cliqué à la console — *« si ce n'est pas dans Git, ça n'existe pas »*.

## Exigences fonctionnelles

| # | Exigence | Pourquoi |
|---|----------|----------|
| F1 | Un cluster Kubernetes managé (EKS) capable d'héberger les microservices SemiShop | valider la cible technique |
| F2 | 3 nœuds de calcul — assez pour les apps + la supervision, pas plus | PoC, pas de la production |
| F3 | Accessible en `kubectl` depuis le poste du participant | travailler dessus au TD 2 |
| F4 | Reconstructible à l'identique par n'importe quel membre de l'équipe | reproductibilité |

## Exigences non fonctionnelles

| # | Exigence | Traduction concrète |
|---|----------|---------------------|
| N1 | 100 % infrastructure as code | Terraform, zéro création à la console |
| N2 | Versionné et relu | dépôt GitHub, une branche par changement, revue avant fusion |
| N3 | Contrôles automatiques | GitHub Actions : format, validité, scan de sécurité à chaque push |
| N4 | Modèle économique | instances `t3.small`, pas de NAT Gateway, destruction en fin de journée |
| N5 | Multi-utilisateurs sur compte partagé | toutes les ressources préfixées `<prenom>-`, taggées `owner` |
| N6 | Région imposée | `eu-west-3` (Paris) — données et latence |

## Budget et durée de vie

- Enveloppe : **moins de 3 $** pour la journée complète.
- Durée de vie de l'infrastructure : **la journée**. Le TD se termine par `terraform destroy` vérifié.

## Hors périmètre (assumé pour un PoC)

- Haute disponibilité multi-région, chiffrement avancé, réseau privé complet (NAT, endpoints VPC) : notés comme **écarts vers la production** dans le rendu final, pas construits.
- La sécurisation applicative du cluster (RBAC, quotas, durcissement) : c'est le **TD 2**.
