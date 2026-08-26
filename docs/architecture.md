---
titre: "TD 1 - Architecture technique cible"
version: "1.0.0"
date_maj: "2026-08-25"
formation: "IA & Infra/DevOps : industrialiser l'IA dans CI/CD, IaC, Kubernetes, GitOps et les operations"
auteur: "Adrien Vossough"
---

# Architecture technique cible — TD 1

Ce document est votre **carte**. Chaque étape du TD construit une partie de ce schéma ; revenez-y à chaque étape pour situer ce que vous êtes en train de créer.

## Vue d'ensemble

```mermaid
flowchart TB
    subgraph t_aws ["Compte AWS partage - region eu-west-3"]
        direction TB
        spacer_1[ ]
        style spacer_1 width:0px,height:0px,fill:none,stroke:none
        subgraph t_vpc ["VPC <prenom>-vpc = votre reseau prive virtuel (10.0.0.0/16)"]
            direction TB
            spacer_2[ ]
            style spacer_2 width:0px,height:0px,fill:none,stroke:none
            t_igw["Internet Gateway<br/>= la porte du VPC vers Internet"]
            subgraph t_az1 ["Zone eu-west-3a (datacenter 1)"]
                t_sub1["Subnet public 10.0.1.0/24<br/>= un quartier du reseau"]
            end
            subgraph t_az2 ["Zone eu-west-3b (datacenter 2)"]
                t_sub2["Subnet public 10.0.2.0/24"]
            end
            t_igw --- t_sub1
            t_igw --- t_sub2
            spacer_2 ~~~ t_igw
        end
        t_eks["Control plane EKS <prenom>-eks (K8s 1.36)<br/>= le cerveau Kubernetes, gere par AWS"]
        t_ng["Node group 3 x t3.small<br/>= les machines qui executent vos pods"]
        t_eks -->|"pilote"| t_ng
        t_ng -->|"tournent dans"| t_sub1
        t_ng -->|"et dans"| t_sub2
        t_iam["2 roles IAM<br/>= cartes d'identite du cluster et des noeuds"]
        t_iam -->|"portes par"| t_eks
        spacer_1 ~~~ t_vpc
    end
    t_poste["Votre poste<br/>terraform + kubectl"] -->|"cree via l'API AWS"| t_aws
    t_gh["GitHub<br/>depot + Actions"] -->|"controle le code"| t_poste
```

## Décisions d'architecture (et leurs raisons)

| Décision | Choix | Pourquoi | L'alternative production |
|----------|-------|----------|--------------------------|
| Kubernetes | EKS 1.36 (managé) | AWS opère le control plane ; version la plus récente en support standard | idem, avec upgrades planifiés |
| Nœuds | 3 x `t3.small` (2 vCPU / 2 Go) | assez pour SemiShop + la supervision du TD 2, ~0,07 $/h les trois | instances plus grosses, autoscaling |
| Réseau | 2 subnets **publics**, pas de NAT Gateway | une NAT coûte ~0,05 $/h + le trafic ; en PoC d'une journée, on l'assume et on le **documente** | nœuds en subnets privés derrière une NAT |
| Zones | 2 AZ (`eu-west-3a`, `3b`) | EKS exige au moins 2 zones ; on encaisse la panne d'un datacenter | 3 AZ |
| IAM | 2 rôles créés par Terraform | le cluster et les nœuds ont chacun leur « carte d'identité » à moindre privilège | idem + rôles applicatifs (IRSA) |
| État Terraform | fichier local `terraform.tfstate` | un seul opérateur par infra, une journée | backend S3 + verrou (travail d'équipe) |
| Nommage | tout préfixé `<prenom>-` | compte AWS **partagé** entre participants | un compte par environnement |
| Tags | `app`, `env`, `owner`, `team` | retrouver qui possède quoi et suivre les coûts | politique de tags imposée |

🟨 **Le compromis à connaître** : des nœuds en subnet public portent une IP publique — le pare-feu (security group géré par EKS) protège, mais la surface d'exposition est réelle. C'est le premier écart « PoC vers prod » de votre rendu, et la porte d'entrée du TD 2 (sécurisation).

## Ce que Terraform crée, ressource par ressource

| Ressource Terraform | Objet AWS créé | Étape du TD |
|---------------------|----------------|-------------|
| `aws_vpc` | le réseau privé virtuel | 3 |
| `aws_subnet` x2 | deux sous-réseaux publics, un par zone | 3 |
| `aws_internet_gateway` | la porte vers Internet | 3 |
| `aws_route_table` + associations | le panneau de routage « 0.0.0.0/0 -> IGW » | 3 |
| `aws_iam_role` x2 + attachements | les identités du control plane et des nœuds | 4 |
| `aws_eks_cluster` | le control plane Kubernetes | 5 |
| `aws_eks_node_group` | les 3 machines `t3.small` | 5 |

## Chaîne de livraison du code

```mermaid
flowchart LR
    t_dev["Vous + l'IA<br/>ecrivez le HCL"] -->|"git push"| t_repo["Depot GitHub<br/>= source de verite"]
    t_repo -->|"declenche"| t_ci["GitHub Actions<br/>fmt + validate + tfsec<br/>= relecteur automatique"]
    t_ci -->|"tout vert"| t_apply["terraform apply<br/>depuis votre poste"]
    t_apply -->|"cree"| t_infra["Infra AWS reelle"]
    t_infra -->|"fin de journee"| t_destroy["terraform destroy"]
```

Versions épinglées (vérifiées le 2026-08-25) : Terraform `>= 1.12` (testé 1.12.2), provider AWS `~> 6.0`, Kubernetes EKS `1.36`.
