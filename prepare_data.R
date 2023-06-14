library(stringr)
library(readr)

path <- list.files("images", pattern = "*.jpg", full.names = TRUE) 

name <- str_remove_all(path, "images/|\\.jpg") 

name <- str_replace_all(name, "-", " ")

name <- str_replace_all(name, "([a-z])([A-Z])", "\\1 \\2")

name <- tolower(name)

illustrations <- data.frame(name, path)

write_csv(illustrations, "data/illustrations.csv")
