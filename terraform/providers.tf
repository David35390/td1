# ==================================================================
# providers.tf - configuration du provider AWS
# Region imposee (cahier des charges N6) + tags par defaut (N5) :
# les 4 tags sont poses automatiquement sur TOUTE ressource taggable,
# on ne peut pas les oublier.
# ==================================================================

provider "aws" {
  # eu-west-3 = Paris. Valeur par defaut de var.region, ne pas changer.
  region = var.region

  # default_tags : appliques par le provider a chaque ressource creee.
  default_tags {
    tags = {
      app   = "semishop"  # l'application du PoC
      env   = "td"        # l'environnement : travail dirige
      owner = var.prenom  # QUI a cree la ressource (suivi des couts)
      team  = "formation" # le groupe, pour filtrer dans la console
      costcenter = "poc-td1" # suivi budget PoC (demande finance)


    }
  }
}
