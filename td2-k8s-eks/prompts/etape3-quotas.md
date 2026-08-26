# Prompt — étape 3 : générer `k8s/quotas.yaml` et `k8s/limitrange.yaml`

À coller après avoir lu le tableau de budget de l'étape 3 du README — c'est
**vous** qui donnez les chiffres à l'assistant, pas l'inverse : le budget
découle de vos nœuds, l'IA ne connaît pas votre cluster.

```text
Contexte : cluster EKS 1.36 de 3 noeuds t3.small (2 vCPU / 2 Go chacun),
deux namespaces existants : "semishop" (applications) et "monitoring"
(Prometheus + Grafana). Je suis débutant : commente chaque champ.

Tâche : écris deux fichiers.

1. k8s/quotas.yaml : un ResourceQuota par namespace.
   - semishop  : requests.cpu=1, requests.memory=1Gi, limits.cpu=2,
                 limits.memory=2Gi, pods=10
   - monitoring : requests.cpu=1, requests.memory=1536Mi, limits.cpu=3,
                 limits.memory=3Gi, pods=15

2. k8s/limitrange.yaml : un LimitRange par namespace (type Container).
   - semishop  : default cpu=250m memory=256Mi,
                 defaultRequest cpu=100m memory=128Mi
   - monitoring : default cpu=200m memory=128Mi,
                 defaultRequest cpu=50m memory=64Mi

Contraintes :
- Ces valeurs sont fermes : ne les "améliore" pas, ne rajoute aucun autre
  plafond (pas de storage, pas de services.loadbalancers).
- Mémoire en Mi/Gi (jamais en "m" minuscule).
- Explique en deux phrases la différence entre ResourceQuota et LimitRange,
  et ce qui se passe pour un pod créé sans requests ni limits.
```

## Checklist de revue avant d'appliquer

- [ ] Deux `ResourceQuota` (un par namespace), noms et namespaces corrects ?
- [ ] Les 5 valeurs `hard` de chaque quota **identiques** au tableau de budget ?
- [ ] Deux `LimitRange` de `type: Container` avec `default` **et** `defaultRequest` ?
- [ ] Aucune unité mémoire en `m` minuscule (millioctets != mébioctets) ?
- [ ] Rien en trop (pas de quota `storage`, pas de `min`/`max` non demandés) ?

🟨 Piège classique : l'assistant « arrondit » volontiers 1536Mi en 1.5Gi ou
ajoute des plafonds non demandés. Les deux notations sont équivalentes pour
Kubernetes, mais gardez celle du tableau — le TD compare des sorties exactes.
