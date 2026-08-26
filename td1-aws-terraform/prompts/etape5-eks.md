# Prompt étape 5 — générer le cluster (eks.tf)

Collez tel quel, puis collez à la suite le contenu actuel de `terraform/eks.tf`.

```text
Tu assistes un debutant complet en Terraform. Tu proposes, je relis
et j'applique moi-meme. Commente chaque ligne de code produite.

Contexte : PoC SemiShop, compte AWS partage, region eu-west-3.
Existent deja : network.tf (aws_vpc.main, aws_subnet.public_a,
aws_subnet.public_b) et iam.tf (aws_iam_role.cluster avec
l'attachement cluster_eks ; aws_iam_role.nodes avec les attachements
nodes_worker, nodes_ecr, nodes_cni). Je colle plus bas mon fichier
eks.tf : il ne contient que des commentaires TODO numerotes qui
decrivent les deux ressources attendues.

Ta tache : ecris le contenu complet de eks.tf en creant EXACTEMENT
ces deux ressources, avec les noms demandes, sans rien ajouter.

Contraintes :
- Cluster : name "<prenom>-eks" (var.prenom), version = "1.36"
  (epinglee, ne propose pas une autre version), role_arn du role
  "cluster", vpc_config avec les DEUX subnets publics.
- depends_on du cluster : l'attachement de policy du role cluster.
- Node group : name "<prenom>-nodes", role "nodes", les deux memes
  subnets, instance_types = ["t3.small"], scaling_config avec
  desired_size = min_size = max_size = 3.
- depends_on du node group : les TROIS attachements de policies des
  noeuds.
- Ressources BRUTES uniquement : n'utilise PAS le module
  terraform-aws-modules/eks. Pas d'addon, pas de launch template,
  pas de ligne ami_type ou disk_size (les defauts conviennent).
- ASCII pur dans le code et les commentaires.

Format : un seul bloc HCL complet pour eks.tf, puis une auto-revue
en 3 lignes : hypotheses prises, ce que tu n'as PAS ajoute.

[collez ici le contenu de terraform/eks.tf]
```

**Ce que vous devez retrouver dans la réponse** :

- 2 ressources exactement : `aws_eks_cluster.main` (version `"1.36"` — pas « la dernière que connaît l'assistant ») et `aws_eks_node_group.main` (3/3/3 en `scaling_config`, `["t3.small"]`).
- Les deux `depends_on` sur les **attachements** de policies (pas sur les rôles) : un rôle sans ses droits fait échouer la création.
- Aucun module externe, aucun addon, aucun `launch_template` : deux blocs, rien autour — si l'assistant a « enrichi », refusez et regénérez.
