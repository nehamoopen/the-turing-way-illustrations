# install.packages("zen4R")

# require("remotes")
# install_github("eblondel/zen4R")

library(zen4R)
library(dplyr)
library(stringr)

zenodo <- ZenodoManager$new(logger = "INFO")

rec <- zenodo$getRecordByDOI("10.5281/zenodo.6821117")

files <- rec$listFiles(pretty = TRUE) %>%
         filter(str_detect(filename, "AllJPG-English-text.zip"))

#create a folder where to download my files

dir.create("images")

# download files

for(i in seq_len(nrow(files))) {
  download.file(url = files$download[i], 
                destfile = file.path("images", files$filename[i]), 
                method = 'auto')
}

relative_paths <- list.files("images", full.names = TRUE)
