# Prompt — étape 7 : compléter les manifests `semishop/`

Ici l'assistant ne part pas de zéro : il complète les squelettes fournis
(`semishop/*.yaml`). Collez-lui le contenu des quatre fichiers à la suite du
prompt (ou laissez votre agent IDE les lire), et donnez-lui **votre** prénom.

```text
Contexte : cluster EKS 1.36 de 3 noeuds t3.small. Le namespace "semishop"
existe, avec un ResourceQuota, un LimitRange et Pod Security en
enforce=baseline + warn=restricted. Je déploie le service "inventory"
(FastAPI, port 8085) et sa base PostgreSQL. Mon prénom : <prenom>.
Je suis débutant : explique chaque valeur que tu remplis.

Tâche : complète les TODO-7.x des quatre fichiers ci-dessous, sans toucher
au reste (probes, securityContext, labels et selectors sont déjà corrects).
- namespace : semishop (partout)
- image du deployment inventory :
  039497794217.dkr.ecr.eu-west-3.amazonaws.com/semishop:<prenom>-1.0.0
- inventory : requests cpu=100m memory=128Mi, limits cpu=500m memory=256Mi
- postgres  : requests cpu=100m memory=256Mi, limits cpu=500m memory=512Mi

Contraintes :
- Ne crée AUCUN objet Secret : le Secret inventory-secrets existe déjà,
  créé en ligne de commande — s'il manque, dis-le-moi au lieu d'en générer un.
- N'ajoute rien : pas d'Ingress, pas de HPA, pas de volume persistant,
  pas d'annotations.
- Mémoire en Mi. L'image garde le tag <prenom>-1.0.0 (registre partagé).

[collez ici le contenu des 4 fichiers semishop/*.yaml]
```

## Checklist de revue avant d'appliquer

- [ ] `namespace: semishop` dans les **4** fichiers (et les **2** objets de `postgres.yaml`) ?
- [ ] L'image porte **votre** prénom dans le tag — pas `adrien`, pas `latest`,
      pas un nom d'image inventé ?
- [ ] `requests` **et** `limits` sur chaque conteneur, mémoire en `Mi` ?
- [ ] Aucun `kind: Secret` apparu dans les fichiers ? Aucun mot de passe en clair ?
- [ ] Les blocs probes et `securityContext` sont **inchangés** ?
- [ ] `grep -rn "a-completer" semishop/` ne retourne plus rien ?

🟨 Piège classique : l'assistant « aide » en générant un Secret YAML avec un
mot de passe d'exemple. C'est précisément ce que la règle 4 du TD interdit —
le Secret se crée en CLI (étape 7 du README) et ne se versionne jamais.
