# load packages

library(zen4R)
library(dplyr)
library(stringr)

# connect to zenodo and get record by doi

zenodo <- ZenodoManager$new(logger = "INFO")

rec <- zenodo$getRecordByDOI("10.5281/zenodo.6821117")

files <- rec$listFiles(pretty = TRUE) %>%
         filter(str_detect(filename, "AllJPG-English-text.zip"))

# create directories for files

dir.create("images")
dir.create("images/zip-files")

# download zip files

options(timeout=300)

for(i in seq_len(nrow(files))) {
  download.file(url = files$download[i], 
  destfile = file.path("images/zip-files", files$filename[i]), 
  method = 'auto')
}

# unzip files

zip_file_paths <- list.files("images/zip-files", full.names = TRUE)

for(i in zip_file_paths) {
  unzip(i, junkpaths = TRUE, exdir = "images")
}

# ------------------------------------------------------------------------------