# Prompt transverse — faire expliquer une erreur (avant toute correction)

À utiliser à **chaque** message d'erreur de la journée (`Forbidden`, `Pending`,
`ImagePullBackOff`, `CrashLoopBackOff`...). La règle du TD : on comprend la
cause **avant** de toucher quoi que ce soit — un correctif non compris sera
reproduit tel quel au prochain incident, erreur comprise.

```text
Contexte : cluster EKS 1.36 de 3 noeuds t3.small (2 Go chacun). Namespace
"semishop" avec ResourceQuota, LimitRange, Pod Security enforce=baseline.
Je suis débutant sur Kubernetes.

Voici la commande que j'ai lancée et l'erreur complète :

[commande]
[message d'erreur, copié en entier — pas un résumé]

Consignes :
1. Explique d'abord la CAUSE : quel mécanisme du cluster a refusé ou échoué,
   et pourquoi (2 à 5 phrases, niveau débutant).
2. Dis-moi quelle commande lancer pour CONFIRMER ce diagnostic (describe,
   get events, logs...), et ce que je dois y lire.
3. Seulement ensuite, propose UNE correction minimale — sans désactiver de
   garde-fou : ne propose jamais de supprimer un quota, un label Pod
   Security ou un droit RBAC pour "débloquer".
4. Si l'erreur peut avoir plusieurs causes, donne-les par ordre de
   probabilité dans mon contexte.
```

## Après la réponse

- Lancez la commande de confirmation **avant** la correction : si le
  diagnostic ne se confirme pas, redonnez la sortie à l'assistant au lieu
  d'appliquer sa correction.
- Chaque erreur expliquée va dans [docs/journal-de-bord.md](../docs/journal-de-bord.md)
  (symptôme -> cause -> correction) : c'est le début de votre base de runbooks.

🟥 Si la « correction minimale » proposée consiste à retirer un garde-fou
(quota, Pod Security, RBAC), refusez et demandez l'alternative — le garde-fou
fait son travail, c'est la charge qui doit s'adapter.
