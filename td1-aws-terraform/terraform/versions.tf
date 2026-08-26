# ==================================================================
# versions.tf - les versions que ce projet exige (regles du TD, no 4)
# On epingle pour que le meme code donne le meme resultat sur tout
# poste : c'est la condition de l'exigence F4 (reconstructible).
# ==================================================================

terraform {
  # Version minimale de l'outil terraform lui-meme.
  # ">= 1.12.0" : toute version a partir de 1.12.0 convient.
  required_version = ">= 1.12.0"

  required_providers {
    # Le provider AWS : le greffon qui traduit nos blocs HCL
    # en appels a l'API AWS.
    aws = {
      source = "hashicorp/aws"
      # "~> 6.61" : accepte 6.61.x et les mineures suivantes (6.62, 6.70...),
      # refuse un saut de majeure (7.x) qui pourrait casser la syntaxe.
      version = "~> 6.61"
    }
  }
}
