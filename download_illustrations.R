install.packages("zen4R")

require("remotes")
install_github("eblondel/zen4R")

library(zen4R)

zenodo <- ZenodoManager$new(logger = "INFO")
zenodo <- ZenodoManager$new()

zenodo <- ZenodoManager$new(
  token = "", 
  logger = "INFO" # use "DEBUG" to see detailed API operation logs, use NULL if you don't want logs at all
)

rec <- zenodo$getRecordByDOI("10.5281/zenodo.6821117")
files <- rec$listFiles(pretty = TRUE)

#create a folder where to download my files
dir.create("images")

# drop records with pdfs

library(dplyr)
library(stringr)
files <- filter(files, str_detect(filename, "jpg"))

# download files

for(i in seq_len(nrow(files))) {
  download.file(url = files$download[i], 
                destfile = file.path("images", files$filename[i]), 
                method = 'auto')
}

relative_paths <- list.files("images", full.names = TRUE)
