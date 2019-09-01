#' Stastistiques issues de croisement de variables
#' @description croise deux dimensions choisies dans la table 
#' @param dimension1 Numéro d'épisode ou saison
#' @param dimension2 personnage ou alliégeance
#'
#' @return 4 tables : 1 clé et 3 tableaux croisés
#'
#' @examples
#' test <- stat_2D_GOT(dimension1 = "N_serie", dimension2 = "allegiance")

stat_2D_GOT <- function(dimension1, dimension2) {
  # Table dim1*dim2*stats
  stats_GOT <-
    data_GOT[order(Season, N_Season), .(
      nb_personnages = n_distinct(personnage),
      nb_lignes_dialogue = .N,
      nb_mots = sum(nbwords)
    ),
    by = c(dimension1,
           dimension2)]
  
  stats_GOT_nb_personnages <-
    tableaucroise_2D_GOT(
      data = stats_GOT,
      dimension1 = dimension1,
      dimension2 = dimension2,
      statistique = "nb_personnages"
    )
  
  
  stats_GOT_nb_lignes <-
    tableaucroise_2D_GOT(
      data = stats_GOT,
      dimension1 = dimension1,
      dimension2 = dimension2,
      statistique = "nb_lignes_dialogue"
    )
  
  stats_GOT_nb_mots <-
    tableaucroise_2D_GOT(
      data = stats_GOT,
      dimension1 = dimension1,
      dimension2 = dimension2,
      statistique = "nb_mots"
    )
  
  return(list(stats_GOT, 
              stats_GOT_nb_personnages, 
              stats_GOT_nb_lignes, 
              stats_GOT_nb_mots))
}

