# Bonnes pratiques IA du TD — l'assistant propose, vous validez

## Le cycle à chaque étape

1. **Cadrer** : collez le prompt fourni (`prompts/`) — il contient le contexte, les contraintes et le format attendu. Un prompt sans contrainte produit du code générique.
2. **Relire avec la checklist** avant de coller le code dans le projet :
   - [ ] Région `eu-west-3` explicite ?
   - [ ] Préfixe `var.prenom` sur chaque nom ?
   - [ ] Les 4 tags présents ?
   - [ ] Versions conformes à `rules/regles-du-td.md` (pas de version inventée) ?
   - [ ] Aucun secret, aucune valeur en dur qui devrait être une variable ?
   - [ ] Rien en trop (l'IA ajoute volontiers des ressources non demandées) ?
3. **Corriger** ce qui ne passe pas la checklist — vous, pas l'IA. Si vous ne comprenez pas une ligne, demandez-lui de l'expliquer **avant** de la garder.
4. **Appliquer vous-même** : `terraform plan`, lecture du plan, puis `apply`. Jamais d'apply proposé par l'IA exécuté sans lecture.

## Ce qu'on ne demande jamais à l'assistant

- D'exécuter quoi que ce soit sur AWS à votre place.
- De « corriger jusqu'à ce que ça passe » sans expliquer la cause de l'erreur.
- Un secret, une clé, ou de contourner une règle du TD.

🔷 Réflexe transverse : chaque erreur rencontrée puis comprise mérite une ligne dans votre note de bord (`docs/journal-de-bord.md`) — c'est elle qui fait la différence entre « ça a marché » et « je sais pourquoi ».
