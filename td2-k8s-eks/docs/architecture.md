---
titre: "TD 2 - Architecture technique cible"
version: "1.0.0"
date_maj: "2026-08-25"
formation: "IA & Infra/DevOps : industrialiser l'IA dans CI/CD, IaC, Kubernetes, GitOps et les operations"
auteur: "Adrien Vossough"
---

# Architecture technique cible — TD 2

Le TD 1 a livré le socle (VPC + EKS 3 nœuds). Le TD 2 remplit le cluster : cloisons, droits, garde-fous, supervision, applications. Votre carte pour la journée :

```mermaid
flowchart TB
    subgraph t_eks ["Cluster EKS <prenom>-eks (du TD 1)"]
        direction TB
        spacer_1[ ]
        style spacer_1 width:0px,height:0px,fill:none,stroke:none
        subgraph t_ns_shop ["Namespace semishop = le quartier des applications"]
            direction TB
            spacer_2[ ]
            style spacer_2 width:0px,height:0px,fill:none,stroke:none
            t_inv["Deployment inventory<br/>(image ECR, non-root)"] --> t_pg["PostgreSQL<br/>(base du service)"]
            t_quota1["ResourceQuota + LimitRange<br/>= plafonds CPU/RAM du quartier"]
            t_pss["Pod Security baseline<br/>= reglement de securite a l'entree"]
            spacer_2 ~~~ t_inv
        end
        subgraph t_ns_mon ["Namespace monitoring = le quartier de la supervision"]
            direction TB
            spacer_3[ ]
            style spacer_3 width:0px,height:0px,fill:none,stroke:none
            t_prom["Prometheus<br/>= collecte et stocke les metriques"] --> t_graf["Grafana<br/>= les affiche en dashboards"]
            spacer_3 ~~~ t_prom
        end
        t_rbac["RBAC : ServiceAccount lecture-seule<br/>= badge visiteur, regarde sans toucher"]
        t_prom -.->|"scrute les pods de"| t_ns_shop
        t_rbac -.->|"peut lire"| t_ns_shop
        spacer_1 ~~~ t_ns_shop
    end
    t_helm["Helm<br/>= gestionnaire de paquets K8s"] -->|"installe kube-prometheus-stack<br/>(values allegees fournies)"| t_ns_mon
    t_kubectl["Votre poste<br/>kubectl + helm"] -->|"applique les manifests"| t_eks
    t_ecr["ECR partage semishop<br/>tag <prenom>-1.0.0"] -->|"fournit l'image"| t_inv
```

## Décisions d'architecture (et leurs raisons)

| Décision | Choix | Pourquoi | L'alternative production |
|----------|-------|----------|--------------------------|
| Isolation | 2 namespaces (`semishop`, `monitoring`) | séparer apps et outillage : droits, quotas et pannes cloisonnés | un namespace par équipe/service |
| Droits | RBAC natif : `Role` + `RoleBinding` sur un `ServiceAccount` lecture seule | démontrer le moindre privilège avec les objets standard | accès humains via IAM (access entries) + groupes |
| Garde-fous | `ResourceQuota` (plafond du namespace) + `LimitRange` (défauts par pod) | 3 nœuds de 2 Go : sans plafond, une app peut affamer la supervision | quotas par équipe + autoscaling |
| Durcissement | Pod Security Standards niveau `baseline` sur `semishop` (labels du namespace) | bloque les pods privilégiés sans installer d'outil tiers | `restricted` + politiques OPA/Kyverno |
| Supervision | chart `kube-prometheus-stack` (Helm), valeurs allégées fournies | la stack de référence, installée en une commande, dimensionnée pour t3.small | stockage long terme, alerting d'astreinte |
| Application | `inventory` (FastAPI) + PostgreSQL, image tirée de l'ECR partagé | le service de référence du fil rouge, déjà conteneurisé | toute la constellation SemiShop |
| Réseau | NetworkPolicies **expliquées, non appliquées** | EKS n'applique pas les NetworkPolicies par défaut (moteur à activer) | VPC CNI network policy agent activé |

## Ce que vous créez, objet par objet

| Objet Kubernetes | Rôle en une phrase | Étape |
|------------------|--------------------|-------|
| `Namespace` x2 | des cloisons logiques dans le cluster | 2 |
| `ResourceQuota` | le plafond total de CPU/RAM d'un namespace | 3 |
| `LimitRange` | les requests/limits par défaut d'un pod qui n'en déclare pas | 3 |
| Labels Pod Security | le règlement de sécurité appliqué à l'entrée du namespace | 4 |
| `ServiceAccount` + `Role` + `RoleBinding` | un badge, une liste de permissions, l'agrafe entre les deux | 5 |
| Release Helm `monitoring` | Prometheus + Grafana installés et configurés d'un bloc | 6 |
| `Deployment` + `Service` (inventory, postgres) | l'application SemiShop supervisée | 7 |

Versions épinglées (à vérifier à l'étape 0 du TD) : Helm >= 3.13, chart `kube-prometheus-stack` épinglé par `--version` (valeur exacte dans le déroulé), Kubernetes 1.36 (cluster du TD 1).
