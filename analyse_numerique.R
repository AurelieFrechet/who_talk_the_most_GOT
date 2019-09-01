





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




