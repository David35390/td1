# Prompt — étape 5 : générer `k8s/rbac/lecteur.yaml`

Le piège de cette étape est connu d'avance : sur une demande RBAC vague, un
assistant propose volontiers un `ClusterRole` — voire `cluster-admin` — « pour
que ça marche ». Le prompt verrouille donc le périmètre ; à vous de vérifier
qu'il a été respecté.

```text
Contexte : cluster EKS 1.36, namespace "semishop". Je veux un compte
technique en LECTURE SEULE, strictement limité à ce namespace — il préfigure
le badge qu'aurait un outil automatique (par exemple un agent IA) branché
sur le cluster. Je suis débutant : commente chaque champ.

Tâche : écris k8s/rbac/lecteur.yaml avec exactement trois objets :
1. Un ServiceAccount "lecteur" dans le namespace semishop.
2. Un Role "lecture-seule" dans semishop qui autorise UNIQUEMENT
   get, list, watch sur : pods, services (groupe core) et deployments
   (groupe apps).
3. Un RoleBinding "lecteur-lecture-seule" qui relie les deux.

Contraintes :
- Role et RoleBinding, PAS ClusterRole ni ClusterRoleBinding : les droits
  ne doivent pas dépasser le namespace semishop.
- Aucun verbe d'écriture (create, delete, patch, update...), aucun wildcard
  ("*") ni dans les verbes, ni dans les ressources, ni dans les apiGroups.
- Explique en deux phrases pourquoi les deployments demandent une règle
  séparée des pods et services.
```

## Checklist de revue avant d'appliquer

- [ ] `kind: Role` et `kind: RoleBinding` — **aucun** objet `Cluster*` ?
- [ ] Verbes : `get`, `list`, `watch` et **rien d'autre** ?
- [ ] Aucun `*` nulle part (verbes, ressources, apiGroups) ?
- [ ] `deployments` bien dans `apiGroups: ["apps"]`, pods/services dans `[""]` ?
- [ ] Le `roleRef` pointe le Role `lecture-seule`, le subject est le
      ServiceAccount `lecteur` du namespace `semishop` ?

🟥 Si l'assistant a produit un `ClusterRole` « parce que c'est plus simple » :
ne corrigez pas en silence. Demandez-lui pourquoi, lisez la réponse, puis
exigez la version namespacée — c'est exactement le réflexe attendu face à une
proposition trop permissive.
