---
titre: "TD 2 - Journal de bord (gabarit a remplir)"
version: "1.0.0"
date_maj: "2026-08-25"
formation: "IA & Infra/DevOps : industrialiser l'IA dans CI/CD, IaC, Kubernetes, GitOps et les operations"
auteur: "<votre prenom et nom>"
---

# Journal de bord — TD 2 : du cluster nu à la plateforme

> Votre compte rendu de la journée. Remplissez-le **au fil de l'eau**, pas à
> 17h de mémoire. C'est le livrable du TD (avec le tableau de sécurité de
> l'étape 8) — et le début de votre base de runbooks.

## Identité

| Champ | Valeur |
|-------|--------|
| Prénom (préfixe des ressources) | |
| Cluster | `<prenom>-eks` |
| Tag d'image poussé sur l'ECR | `<prenom>-1.0.0` |
| Version du chart kube-prometheus-stack installée | |

## Suivi des étapes

Une ligne par étape : ce que vous avez appliqué, la commande de vérification
qui a prouvé que c'était bon, et l'heure — utile pour retrouver un événement
dans Grafana ensuite.

| Étape | Fait à (heure) | Preuve de réussite (commande + résultat en un mot) | Aide IA : ce que vous avez corrigé dans sa proposition |
|-------|----------------|-----------------------------------------------------|--------------------------------------------------------|
| 0 — Reprise du cluster | | | |
| 1 — Carte mentale kubectl | | | |
| 2 — Namespaces | | | |
| 3 — Quotas + LimitRange | | | |
| 4 — Pod Security | | | |
| 5 — RBAC lecture seule | | | |
| 6 — Helm + supervision | | | |
| 7 — SemiShop déployé | | | |
| 8 — Destruction | | | |

## Erreurs rencontrées et expliquées

Une ligne par erreur — y compris celles provoquées exprès par le TD (quota
dépassé, pod privilégié rejeté). Symptôme = le message brut ; cause = avec vos
mots ; c'est la matière première de vos futurs runbooks.

| Symptôme (message exact) | Cause (vos mots) | Comment confirmé (commande) | Correction appliquée |
|--------------------------|------------------|------------------------------|----------------------|
| | | | |
| | | | |
| | | | |

## Ce que la plateforme empêche désormais (à remplir à l'étape 8)

Recopiez et complétez le tableau récapitulatif de sécurité de l'étape 8 du
README, puis ajoutez une ligne personnelle : l'incident que VOUS auriez causé
cette semaine sans ces garde-fous.

## Écarts vers la production (à remplir à l'étape 8)

Listez au moins 4 écarts entre cette plateforme PoC et une plateforme de
production, avec pour chacun : le risque couvert, et l'outil ou la pratique
qui le couvrirait (la liste guidée est à l'étape 8 du README).

| Écart | Risque non couvert en PoC | Réponse en production |
|-------|---------------------------|------------------------|
| | | |
| | | |
| | | |
| | | |

## Trois choses que vous retenez de la journée

1.
2.
3.
