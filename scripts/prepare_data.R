# load libraries

library(stringr)
library(purrr)
library(readr)

# get paths to files

path <- list.files("images", pattern = "*.jpg", full.names = TRUE) 

# clean up names for files

name <- str_remove_all(path, "images/|\\.jpg") %>%
        str_replace_all("-", " ") %>% 
        str_replace_all("([a-z])([A-Z])", "\\1 \\2") %>%
        tolower()

# create dataframe

illustrations <- data.frame(name, path)

# write dataframe to csv

dir.create("data")
write_csv2(illustrations, "data/illustrations.csv")
