# Règles du TD 2 — non négociables

1. **Namespace explicite** dans chaque manifest (`semishop` pour les apps, `monitoring` pour la supervision). Rien dans `default`.
2. **Requests et limits sur chaque conteneur** — le cluster fait 3 x 2 Go, un pod sans limite peut affamer les autres. Le `LimitRange` pose un filet, il ne dispense pas d'y penser.
3. **Non-root** : `runAsNonRoot: true` sur les pods applicatifs (l'image `inventory` du TD tourne avec l'utilisateur 10001).
4. **Zéro secret en clair** : les mots de passe vivent dans des `Secret` Kubernetes créés en ligne de commande, jamais dans un YAML versionné ni dans un prompt.
5. **Helm épinglé** : toute installation de chart passe par `--version` explicite. Pas de « latest » implicite.
6. **Images ECR taggées au prénom** (`<prenom>-1.0.0`) — le registre est partagé, un tag nu écraserait celui d'un autre participant.
7. **`--dry-run=client` avant le premier `apply`** d'un manifest nouveau ; lecture du diff avant un `apply` de modification.
8. **Un seul cluster par participant, le vôtre** : vérifiez le contexte (`kubectl config current-context`) avant chaque série de commandes.
