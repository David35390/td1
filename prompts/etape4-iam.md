# Prompt étape 4 — générer les identités (iam.tf)

Collez tel quel, puis collez à la suite le contenu actuel de `terraform/iam.tf`.

```text
Tu assistes un debutant complet en Terraform. Tu proposes, je relis
et j'applique moi-meme. Commente chaque ligne de code produite.

Contexte : PoC SemiShop, compte AWS partage, region eu-west-3.
default_tags deja configures dans le provider. var.prenom prefixe
tous les noms. Je prepare un cluster EKS : il me faut le role IAM du
control plane et le role IAM des noeuds. Je colle plus bas mon
fichier iam.tf : il ne contient que des commentaires TODO numerotes
qui decrivent les ressources attendues et leurs noms.

Ta tache : ecris le contenu complet de iam.tf en creant EXACTEMENT
les ressources decrites par les TODO, avec les noms demandes,
sans rien ajouter.

Contraintes :
- Role "cluster" : name "<prenom>-eks-cluster-role", endosse par le
  service eks.amazonaws.com uniquement (assume_role_policy en
  jsonencode). Une seule policy attachee :
  arn:aws:iam::aws:policy/AmazonEKSClusterPolicy
- Role "nodes" : name "<prenom>-eks-node-role", endosse par
  ec2.amazonaws.com. Exactement trois policies attachees :
  arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy
  arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly
  arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy
- UNIQUEMENT ces policies managees AWS, aux ARN exacts ci-dessus :
  pas de policy inventee, pas de policy inline personnalisee, et
  JAMAIS AdministratorAccess ni PowerUserAccess.
- ASCII pur dans le code et les commentaires.

Format : un seul bloc HCL complet pour iam.tf, puis une auto-revue
en 3 lignes : hypotheses prises, droits que tu n'as PAS accordes.

[collez ici le contenu de terraform/iam.tf]
```

**Ce que vous devez retrouver dans la réponse** :

- 6 ressources exactement : 2 `aws_iam_role` + 4 `aws_iam_role_policy_attachment`, avec les 4 ARN de policies **à l'identique, caractère par caractère** (comparez avec ce prompt — un ARN inventé ne se voit qu'à l'apply).
- Deux principals différents : `eks.amazonaws.com` pour le rôle cluster, `ec2.amazonaws.com` pour le rôle des nœuds — s'ils sont identiques, la réponse est fausse.
- Aucune policy « bonus » : ni `AdministratorAccess`, ni policy inline maison — c'est l'écart le plus fréquent des assistants sur ce prompt, la checklist de `rules/ia-bonnes-pratiques.md` a une ligne pour ça (« rien en trop »).
