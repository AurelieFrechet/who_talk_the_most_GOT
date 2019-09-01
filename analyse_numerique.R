





# 10 - Chargement des données et des packages -----------------------------

library(data.table)
library(dplyr)
library(highcharter)
library(reshape2)
library(pipeR)


data_GOT <- readRDS("data/data_GOT.RDS") %>% as.data.table()


# 11 - Création de variables ----------------------------------------------


data_GOT[, nbwords := sapply(strsplit(Sentence, " "), length)]


# 12 - Stats par saison / épisode / allégiance-----------------------------

stats_GOT <-
  data_GOT[order(Season, N_Season), .(
    nb_personnages = n_distinct(personnage),
    nb_lignes_dialogue = .N,
    nb_mots = sum(nbwords)
  ),
  by = .(N_serie,
         allegiance)]


# Mise en tableau croisé

stats_GOT_nb_personnages <-
  dcast(stats_GOT, N_serie ~ allegiance, value.var = "nb_personnages") %>%
  as.data.table()
stats_GOT_nb_personnages <-
  stats_GOT_nb_personnages[, lapply(.SD, function(x)
    ifelse(is.na(x), 0, x))]

stats_GOT_nb_lignes <-
  dcast(stats_GOT, N_serie ~ allegiance, value.var = "nb_lignes_dialogue") %>%
  as.data.table()
stats_GOT_nb_lignes <-
  stats_GOT_nb_lignes[, lapply(.SD, function(x)
    ifelse(is.na(x), 0, x))]

stats_GOT_nb_mots <-
  dcast(stats_GOT, N_serie ~ allegiance, value.var = "nb_mots") %>%
  as.data.table()
stats_GOT_nb_mots <-
  stats_GOT_nb_mots[, lapply(.SD, function(x)
    ifelse(is.na(x), 0, x))]



# 13 - Mise en fonction ----------------------------------------------------

## Paramètres d'entrée :
# - dimension 1 : numéro d'épisode ou saison
# - dimension 2 : personnage ou alliégeance
## Sortie :
# - Tableau croisé pour dessin graphique
# - Tableau pour enrichir les stats en textuel

tableaucroise_2D_GOT <-
  function(data, dimension1, dimension2, statistique) {
    result <-
      dcast(data, eval(parse(text = paste(dimension1, "~" ,dimension2))), value.var = "nb_mots") %>%
      as.data.table()
    result <-
      result[, lapply(.SD, function(x)
        ifelse(is.na(x), 0, x))]
    return((result))
  }
# test <- tableaucroise_2D_GOT(data = stats_GOT,
#                              dimension1 = "N_serie", 
#                              dimension2 = "allegiance", 
#                              statistique = "nb_mots")

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

test <- stat_2D_GOT(dimension1 = "N_serie", 
                    dimension2 = "allegiance")
