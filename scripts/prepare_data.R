library(stringr)
library(purrr)
library(readr)

path <- list.files("images", pattern = "*.jpg", full.names = TRUE) 

name <- str_remove_all(path, "images/|\\.jpg") %>%
        str_replace_all("-", " ") %>% 
        str_replace_all("([a-z])([A-Z])", "\\1 \\2") %>%
        tolower()

illustrations <- data.frame(name, path)

write_csv(illustrations, "data/illustrations.csv")
