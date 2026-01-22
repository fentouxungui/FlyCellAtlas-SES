library(SeuratExplorerServer)
apps_home_dir <- '../shiny-server/apps'
apps_data_source <- '../Data'
# each qs2/rds file should located in different directory
# put scRNAseq data from same tissue under a same app
tissues <- basename(list.dirs(apps_data_source, recursive = FALSE))
for (a_tissue in tissues) {
  app_dir <- normalizePath(file.path(apps_home_dir, a_tissue))
  dir.create(app_dir, showWarnings = FALSE)
  file.copy('app.R_demo', file.path(app_dir, 'app.R'))
  all_seurat_files <- normalizePath(list.files(file.path(apps_data_source, a_tissue), pattern = '(.rds$)|(.qs2$)', full.names = TRUE, recursive = TRUE))
  data_meta <- initialize_metadata(Reports.main = dirname(all_seurat_files), 
                                   Rds.path = basename(all_seurat_files), 
                                   Reports.second = rep(NA, length(all_seurat_files)), 
                                   Sample.name = basename(dirname(all_seurat_files)))
  saveRDS(data_meta,file = file.path(app_dir, "data_meta.rds"))
}


