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
dir.create("images/zip-files")

# download files
# set timeout option with `options(timeout=300)` and double-check it with `getOption('timeout')`

for(i in seq_len(nrow(files))) {
  download.file(url = files$download[i], 
  destfile = file.path("images/zip-files", files$filename[i]), 
  method = 'auto')
}

# unzip files

zip_file_paths <- list.files("images/zip-files", full.names = TRUE)

for(i in zip_file_paths) {
  unzip(i, exdir = "images/zip-files")
}

unlink("images/zip-files/__MACOSX", recursive = TRUE)

# move illustrations to images

images_current_paths <- list.files("images/zip-files", pattern = "*.jpg", recursive = TRUE, full.names = TRUE)

images_final_paths <- images_current_paths %>%
                      str_remove_all("zip-files/zz-TheTuringWay-previous-Scriberia-2022-Jun-AllJPG-English-text/")

images_paths <- data.frame(images_current_paths, images_final_paths)

for (i in 1:nrow(images_paths)) {
  file.rename(images_paths$images_current_paths[i], images_paths$images_final_paths[i])
}

file.remove(images_current_paths)


