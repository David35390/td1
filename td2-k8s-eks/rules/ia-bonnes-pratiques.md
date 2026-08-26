# Bonnes pratiques IA du TD — l'assistant propose, vous validez

## Le cycle à chaque étape

1. **Cadrer** : collez le prompt fourni (`prompts/`) — contexte, contraintes, format attendu inclus.
2. **Relire avec la checklist** avant de coller un manifest dans le projet :
   - [ ] `namespace` explicite et correct ?
   - [ ] `requests` **et** `limits` sur chaque conteneur, compatibles avec 3 nœuds de 2 Go ?
   - [ ] Non-root là où la règle l'exige ?
   - [ ] Image : celle de l'ECR partagé, taggée `<prenom>-...` (pas une image inventée) ?
   - [ ] Aucun secret en clair ?
   - [ ] Rien en trop (HPA, ingress, annotations exotiques non demandés) ?
3. **Corriger**, puis **appliquer vous-même** : `kubectl apply --dry-run=client` d'abord, lecture, puis apply réel.
4. **Vérifier l'effet** avec la commande de contrôle de l'étape avant de passer à la suite.

## Ce qu'on ne demande jamais à l'assistant

- D'exécuter une commande sur le cluster à votre place.
- Un manifest « qui marche » sans comprendre pourquoi le précédent échouait.
- De désactiver un garde-fou (quota, Pod Security, RBAC) pour « débloquer » — on comprend le refus, on ne le contourne pas.

🔷 Réflexe transverse : chaque `Forbidden`, chaque `Pending` expliqué va dans votre `docs/journal-de-bord.md` — c'est votre future base de runbooks.
