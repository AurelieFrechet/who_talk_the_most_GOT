
# 00 - Chargement des packages --------------------------------------------

library(data.table)


data_GOT <- fread("C:/Users/Aurelie/Documents/UnJourUneViz/who_talk_the_most_GOT/data/got_scripts_breakdown.csv",
                  encoding = "UTF-8")




personnages <- data_GOT[, .(nb_occurences = .N), by = .(Name)]
personnages[order(nb_occurences, decreasing = TRUE)]


# 01 - Caractéristique des personnages -----------------------------------------

# Petit filtre : au moins deux lignes de dialogue pour faire partie des données
perso_exclus <- personnages[nb_occurences == 1]$Name
data_GOT <- data_GOT[!(Name %in% perso_exclus)]


## Maison du début de la saison
# source : https://fr.wikipedia.org/wiki/Personnages_de_Game_of_Thrones


# 1.1 Maison Arryn
maison_arryn <- data.table(
  personnage = c("Robin Arryn",
                 "Lysa Arryn",
                 "Jon Arryn",
                 "Anya Vanbois",
                 "Yohn Royce",
                 "Donnel Vanbois",
                 "Mord",
                 "Shagga",
                 "Timett",
                 "Hugh of the Vale",
                 "Vardis Egen"),
  allegiance = "Maison Arryn"
)

# 1.2 Maison Baratheon
maison_baratheon <- data.table(
  personnage = c("Tommen Baratheon",
                 "Robert Baratheon",
                 "Joffrey Baratheon",
                 "Myrcella Baratheon",
                 "Stannis Baratheon",
                 "Selyse Florent",
                 "Shireen Baratheon",
                 "Davos Mervault",
                 "Melisandre",
                 "Matthos Mervault",
                 "Maester Cressen",
                 "Renly Baratheon"),
  allegiance = "Maison Baratheon"
)

# 1.3 Maison Bolton
maison_bolton <- data.table(
  personnage = c("Ramsay Bolton (ex-Snow)",
                 "Roose Bolton",
                 "Walda Frey",
                 "Myranda",
                 "Locke"),
  allegiance = "Maison Bolton"
)

# 1.4 Maison Frey
maison_frey <- data.table(
  personnage = c("Walder Frey",
                 "Lothar Frey"),
  allegiance = "Maison Frey"
)

# 1.5 Maison Greyjoy
maison_greyjoy <- data.table(
  personnage = c("Theon Greyjoy",
                 "Balon Greyjoy",
                 "Yara Greyjoy",
                 "Euron Greyjoy",
                 "Dagmer",
                 "Lorren"),
  allegiance = "Maison Greyjoy"
)

# 1.6 Maison Lannister
maison_lannister <- data.table(
  personnage = c("Tyrion Lannister",
                 "Jaime Lannister",
                 "Cersei Lannister",
                 "Kevan Lannister",
                 "Lancel Lannister",
                 "Tywin Lannister",
                 "Alton Lannister",
                 "Martyn Lannister",
                 "Willem Lannister",
                 "The Mountain",
                 "Amory Lorch",
                 "Polliver",
                 "The Tickler"),
  allegiance = "Maison Lannister"
)

# 1.7 Maison Martell
maison_martell <- data.table(
  personnage = c("Ellaria Sand",
                 "Tyene Sand",
                 "Nymeria Sand",
                 "Obara Sand",
                 "Doran Martell",
                 "Trystane Martell",
                 "Oberyn Martell",
                 "Areo Hotah"),
  allegiance = "Maison Martell"
)

# 1.8 Maison Stark
maison_stark <- data.table(
  personnage = c("Jon Snow",
                 "Sansa Stark",
                 "Arya Stark",
                 "Bran Stark",
                 "Eddard Stark",
                 "Catelyn Tully",
                 "Robb Stark",
                 "Talisa Maegyr",
                 "Rickon Stark",
                 "Meera Reed",
                 "Osha",
                 "Hodor",
                 "Jojen Reed",
                 "Lyanna Mormont",
                 "Maester Luwin",
                 "Maester Volkan",
                 "Rodrik Cassel",
                 "Jory Cassel",
                 "Old Nan",
                 "Septa Mordane",
                 "Rickard Karstark",
                 "Torhen Karstark",
                 "Harald Karstark",
                 "Jon Umber",
                 "Ned Omble",
                 "Alys Karstark"),
  allegiance = "Maison Stark"
)
# 1.9 Maison Targaryen
maison_targaryen <- data.table(
  personnage = c("Daenerys Targaryen",
                 "Viserys Targaryen",
                 "Jorah Mormont",
                 "Daario Naharis",
                 "Missandei",
                 "Grey Worm",
                 "Barristan Selmy",
                 "Kovarro",
                 "Rakharo",
                 "Doreah",
                 "Irri"),
  allegiance = "Maison Targaryen"
)

# 1.10 Maison Tully
maison_tully <- data.table(
  personnage = c("Edmure Tully",
                 "Brynden Tully",
                 "Roslin Frey",
                 "Hoster Tully"),
  allegiance = "Maison Tully"
)

# 1.11 Maison Tyrell
maison_tyrell <- data.table(
  personnage = c("Olenna Tyrell",
                 "Margaery Tyrell",
                 "Loras Tyrell",
                 "Mace Tyrell"),
  allegiance = "Maison Tyrell"
)

# 1.12 Peuple de Westeros
membres_cour <- data.table(
  personnage = c("Littlefinger",
                 "Varys",
                 "Grand Maester Pycelle",
                 "High Sparrow",
                 "Qyburn",
                 "High Septon",
                 "Ilyn Payne",
                 "Hallyne",
                 "Meryn Trant",
                 "Dontos Hollard"),
  allegiance = "Membres de la Cour et officiels"
)

peuple_westeros <- data.table(
  personnage = c("Brienne of Tarth",
                 "Podrick Payne",
                 "Bronn",
                 "Sandor Clegane",
                 "Randyll Tarly",
                 "Dickon Tarly",
                 "ArchiMaester Ebrose",
                 "Gendry",
                 "Béric Dondarrion",
                 "Thoros of Myr",
                 "Olyvar",
                 "Marillion",
                 "Tobho Mott",
                 "Anguy",
                 "Shae",
                 "Ros",
                 "Septa Unella",
                 "Frère Ray",
                 "Lem Lemoncloak",
                 "Lommy Greenhands",
                 "Rorge",
                 "Biter",
                 "Syrio Forel",
                 "Mycah"),
  allegiance = "Peuple de Westeros"
)


# 1.13 Peuple d'Essos
peuple_essos <- data.table(
  personnage = c("Jaqen H'ghar",
                 "The Waif",
                 "Harry Strickland",
                 "Lady Crane",
                 "Razdal mo Eraz",
                 "Tycho Nestoris",
                 "Salladhor Saan",
                 "Yezzan",
                 "Illyrio Mopatis",
                 "Quaithe",
                 "Khal Drogo",
                 "Qhono",
                 "Hizdahr zo Loraq",
                 "Qotho",
                 "Mirri Maz Duur",
                 "Xaro Xhoan Daxos",
                 "Pyat Pree",
                 "The Spice King",
                 "Kraznys mo Naklaz",
                 "Prendahl na Ghezn",
                 "Belicho Paenymion"),
  allegiance = "Peuple d'Essos"
)

# 1.14 Le Mur et au-delà
the_watch <- data.table(
  personnage = c("Samwell Tarly",
                 "Eddison Tallett",
                 "Othell Yarwyck",
                 "Alliser Thorne",
                 "Olly",
                 "Bowen Marsh",
                 "Benjen Stark",
                 "Jeor Mormont",
                 "Maester Aemon",
                 "Janos Slynt",
                 "Yoren",
                 "Qhorin",
                 "Grenn",
                 "Rast",
                 "Pypar",
                 "Karl Tanner",
                 "Will",
                 "Waymar Royce"),
  allegiance = "the Night Watch" )

peuple_libre <- data.table(
  personnage = c("Tormund",
                 "Gilly",
                 "Mance Rayder",
                 "Ygritte",
                 "Rattleshirt",
                 "Orell",
                 "Craster",
                 "Styr",
                 "Wun Wun",
                 "The Three Eyed Raven",
                 "Leaf"),
  allegiance = "Peuple Libre"
)

all_characters <- rbindlist(list(maison_arryn,
                            maison_baratheon,
                            maison_bolton,
                            maison_frey,
                            maison_greyjoy,
                            maison_lannister,
                            maison_martell,
                            maison_stark,
                            maison_targaryen,
                            maison_tully,
                            maison_tyrell,
                            membres_cour,
                            peuple_westeros,
                            peuple_essos,
                            the_watch,
                            peuple_libre))

# 02 - Recherche des noms des personnages ----------------------------
personnages <- unique(data_GOT$Name)

Name_script <- sapply(
  X = personnages, function(x){
    ind <- pmatch(x, tolower(all_characters$personnage), duplicates.ok = TRUE)
    all_characters$personnage[ind]
  })

script_names <- data.table(
  Name       = names(Name_script),
  personnage = Name_script
)

# Correction manuelle 
script_names[Name %in% c("man", "all"), personnage := "Unknown"]
script_names[Name %in% c("jon"), personnage := "Jon Snow"]

# Verif de la récupération
sum(is.na(script_names$personnage))/nrow(script_names)

all_characters[!(personnage %in% script_names$personnage)]
# C'est raisonnable, tous les autres seront "Unknown"

script_names[is.na(personnage), personnage := "Unknown"]




