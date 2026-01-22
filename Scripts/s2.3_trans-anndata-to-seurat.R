library(qs2)
library(schard)
data_dir <- '~/ShinyServer/FlyCellAtlas-SES/Data/'
h5ad_files_updated <- list.files(data_dir, pattern = '_new.h5ad', recursive = TRUE, full.names = TRUE)
h5ad_files_updated

for (h5ad_file_updated in h5ad_files_updated) {
  print(h5ad_file_updated)
  new_file_name <- gsub('_new.h5ad', '.qs2', h5ad_file_updated)
  if (file.exists(new_file_name)) {
    print('escaped!')
  }else{
    cds <- h5ad2seurat(h5ad_file_updated)
    qs_save(cds, file = new_file_name)
  }
}
