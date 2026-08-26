# Prompt étape 3 — générer le réseau (network.tf)

Collez tel quel, puis collez à la suite le contenu actuel de `terraform/network.tf` (les blocs vides avec leurs TODO).

```text
Tu assistes un debutant complet en Terraform. Tu proposes, je relis
et j'applique moi-meme. Commente chaque ligne de code produite.

Contexte : PoC SemiShop sur un compte AWS partage entre participants,
region eu-west-3 (variable var.region, defaut eu-west-3). Le provider
est deja configure avec default_tags (app, env, owner, team) : ne
remets aucun de ces tags dans les ressources. Une variable var.prenom
prefixe tous les noms. Je colle plus bas mon fichier network.tf : des
blocs de ressources vides avec des commentaires TODO numerotes.

Ta tache : complete network.tf en remplissant EXACTEMENT ces blocs,
sans en ajouter ni en renommer (d'autres fichiers referencent ces
noms).

Contraintes :
- VPC 10.0.0.0/16, enable_dns_support et enable_dns_hostnames a true.
- 2 subnets publics : 10.0.1.0/24 en zone "a", 10.0.2.0/24 en zone
  "b", availability_zone construite a partir de var.region,
  map_public_ip_on_launch = true (PoC sans NAT Gateway, assume).
- PAS de NAT Gateway, pas d'Elastic IP, pas de security group : rien
  d'autre que les blocs fournis.
- La route 0.0.0.0/0 vers l'IGW est un bloc route DANS la ressource
  aws_route_table (pas une ressource aws_route separee).
- Chaque ressource nommable porte un tag Name = "<prenom>-..."
  construit avec var.prenom (ex. "${var.prenom}-vpc").
- ASCII pur dans le code et les commentaires (pas d'accent).

Format : un seul bloc de code HCL complet pour network.tf, puis une
auto-revue en 3 lignes : hypotheses prises, et ce que tu n'as
volontairement PAS cree.

[collez ici le contenu de terraform/network.tf]
```

**Ce que vous devez retrouver dans la réponse** :

- 7 ressources exactement : le VPC, 2 subnets, l'IGW, la table de routage (avec sa route interne), 2 associations — rien de plus (une NAT ou un security group en plus = hors cahier des charges).
- `map_public_ip_on_launch = true` sur les deux subnets, et les zones construites avec `var.region` (`"${var.region}a"`, `"${var.region}b"`), pas codées en dur.
- Des tags `Name` construits avec `var.prenom`, et **aucun** tag `app`/`env`/`owner`/`team` répété (ils viennent de `default_tags`).

🟨 Passez ensuite la checklist de `rules/ia-bonnes-pratiques.md` avant de coller quoi que ce soit dans votre projet.
