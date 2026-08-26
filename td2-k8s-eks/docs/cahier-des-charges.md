---
titre: "TD 2 - Cahier des charges - plateforme EKS prete pour SemiShop"
version: "1.0.0"
date_maj: "2026-08-25"
formation: "IA & Infra/DevOps : industrialiser l'IA dans CI/CD, IaC, Kubernetes, GitOps et les operations"
auteur: "Adrien Vossough"
---

# Cahier des charges — de « cluster nu » à « plateforme prête »

🟤 **Contexte client**. Le PoC d'infrastructure du TD 1 a convaincu : le cluster EKS se monte et se détruit en une commande. Mais Adrien Vossough est formel : *« un cluster nu n'est pas une plateforme »*. Avant d'y déployer SemiShop, il faut des cloisons (namespaces), des droits maîtrisés (RBAC), des garde-fous de ressources (quotas), un durcissement de base — et **des yeux** : sans supervision, le premier incident sera invisible. Guive Voss ajoute la contrainte d'outillage : tout ce qui s'installe passe par **Helm**, le gestionnaire de paquets de Kubernetes, pour rester reproductible.

## Exigences fonctionnelles

| # | Exigence | Pourquoi |
|---|----------|----------|
| F1 | Espaces isolés : `semishop` (applications) et `monitoring` (supervision) | une panne ou une bêtise ne déborde pas |
| F2 | Un compte technique en **lecture seule** sur `semishop`, démontré | préparer l'arrivée d'outils (et d'IA) non décisionnaires |
| F3 | Supervision Prometheus + Grafana installée via Helm, dashboards accessibles | voir l'état du cluster et des apps |
| F4 | L'application SemiShop (`inventory` + sa base PostgreSQL) déployée et supervisée | la plateforme sert à ça |

## Exigences non fonctionnelles

| # | Exigence | Traduction concrète |
|---|----------|---------------------|
| N1 | Limites de ressources partout | `ResourceQuota` par namespace + `LimitRange` par défaut — 3 nœuds de 2 Go, rien ne doit pouvoir tout manger |
| N2 | Durcissement de base | Pod Security Standards (`baseline` imposé sur `semishop`), conteneurs non-root, pas de secret en clair dans les manifests |
| N3 | Tout est déclaratif et versionné | manifests YAML + `values` Helm dans le dépôt Git du TD |
| N4 | Économie | la stack de supervision est **allégée** (valeurs fournies) pour tenir sur 3 x t3.small |
| N5 | Traçabilité | chaque `helm install` et chaque `kubectl apply` est rejouable depuis le dépôt |

## Budget et durée de vie

- Le cluster du TD 1 continue de tourner (~0,17 $/h). En fin de TD 2 : **destruction** (`terraform destroy` depuis le lab du TD 1), sauf consigne contraire du formateur.

## Hors périmètre (écarts vers la production, à lister dans le rendu)

- NetworkPolicies appliquées (le moteur d'application n'est pas actif par défaut sur EKS : expliqué, non déployé), gestion de secrets externalisée (Vault/Secrets Manager), ingress + TLS, alerting vers un canal d'astreinte, sauvegardes.
