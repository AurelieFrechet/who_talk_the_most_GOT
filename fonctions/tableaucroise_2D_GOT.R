#' Tableau croisé deux dimensions
#'
#' @param data jeu de données
#' @param dimension1 1e dimension du tableau
#' @param dimension2 2e dimension du tableau
#' @param statistique Variable à synthétiser
#'
#' @return Tableau croisé NA remplacés par des 0
#' @export
#'
#' @examples
#' # test <- tableaucroise_2D_GOT(data = stats_GOT, dimension1 = "N_serie",  dimension2 = "allegiance",  statistique = "nb_mots")

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


