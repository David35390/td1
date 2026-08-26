# Prompt — étape 2 : générer `k8s/namespaces.yaml`

À coller tel quel dans votre assistant (ChatGPT, Codex...). Si votre outil lit
le dépôt (Codex CLI, agent IDE), il a déjà le contexte via `AGENTS.md` — le
prompt reste le même. Puis déroulez le cycle de
[rules/ia-bonnes-pratiques.md](../rules/ia-bonnes-pratiques.md) : relire,
corriger, appliquer vous-même.

```text
Contexte : je transforme un cluster EKS nu (Kubernetes 1.36, 3 noeuds t3.small)
en plateforme pour une boutique nommée SemiShop. Je suis débutant sur
Kubernetes : commente chaque champ du YAML que tu produis.

Tâche : écris un fichier k8s/namespaces.yaml qui crée deux namespaces :
- "semishop" : les applications
- "monitoring" : la supervision (Prometheus + Grafana viendront plus tard)

Contraintes :
- Chaque namespace porte les labels app.kubernetes.io/part-of=semishop
  et environment=poc.
- Aucun autre objet que les deux Namespace : pas de quota, pas de RBAC,
  pas d'annotations exotiques — ces objets viendront dans des fichiers dédiés.
- YAML uniquement, sans accents dans les commentaires, deux documents
  séparés par "---" dans le même fichier.

Format attendu : le contenu complet du fichier, puis deux phrases qui
expliquent ce qu'un namespace isole vraiment (et ce qu'il n'isole pas).
```

## Checklist de revue avant d'appliquer

- [ ] Exactement **2 objets** `kind: Namespace`, rien d'autre ?
- [ ] Noms exacts : `semishop` et `monitoring` (minuscules, sans espace) ?
- [ ] Les deux labels demandés présents sur **chacun** des deux ?
- [ ] Rien en trop (pas de `ResourceQuota`, pas de `NetworkPolicy` glissée « en bonus ») ?

🔷 La réponse de l'assistant sur « ce qu'un namespace n'isole pas » vaut la
lecture : un namespace cloisonne les **noms, les droits et les quotas** — pas
le réseau (voir l'encadré NetworkPolicies de l'étape 4 du README).
