# ==================================================================
# variables.tf - les deux parametres du projet
# Une variable = une valeur qui change selon la personne ou le
# contexte, sans toucher au code. Ici : votre prenom, et la region.
# ==================================================================

variable "prenom" {
  description = "Votre prenom en minuscules ASCII : prefixe de toutes les ressources (compte AWS partage)"
  type        = string

  # La validation refuse les valeurs qui casseraient le nommage AWS :
  # majuscules, accents, espaces. Message affiche des le plan.
  validation {
    condition     = can(regex("^[a-z][a-z0-9]*$", var.prenom))
    error_message = "Le prenom doit etre en minuscules ASCII, sans espace ni accent ni tiret (ex. adrien, guive)."
  }
}

variable "region" {
  description = "Region AWS imposee par le cahier des charges (Paris)"
  type        = string
  default     = "eu-west-3"
}
