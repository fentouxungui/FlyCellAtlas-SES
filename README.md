# Deploy FLY CELL ATLAS database by SeuratExplorer Server

> why do this?
As a step-by-step tutorial to guides users build their own scRNAseq database by R package - SeuratExplorerServer, which also provide researchers a new tool to investigate fly scRNAseq data.

## prepare data

Download data from [FLY CELL ATLAS](https://flycellatlas.org/), only select H5AD files.

** method 1 **

use specific download managers, such as Neat Download Manager (for windows) or Uget (for linux).

** method 2 **

too slow, not recommended!

```
sh download_data.sh
```

the organized directory:

```
Data
├── Antenna
│ ├── 10×
│ │ └── s_fca_biohub_antenna_10x.h5ad
│ └── Smart-seq2
│     └── antenna.h5ad
├── Body
│ └── 10×
│     └── s_fca_biohub_body_10x.h5ad
├── Bodywall
│ ├── 10×
│ │ └── s_fca_biohub_body_wall_10x.h5ad
│ └── Smart-seq2
│     └── body_wall.h5ad
├── Fatbody
│ ├── 10×
│ │ └── s_fca_biohub_fat_body_10x.h5ad
│ └── Smart-seq2
│     └── fat_body.h5ad
├── Gut
│ ├── 10×
│ │ └── s_fca_biohub_gut_10x.h5ad
│ └── Smart-seq2
│     └── gut.h5ad
├── Haltere
│ ├── 10×
│ │ └── s_fca_biohub_haltere_10x.h5ad
│ └── Smart-seq2
│     └── haltere.h5ad
├── Head
│ └── 10×
│     └── s_fca_biohub_head_10x.h5ad
├── Heart
│ ├── 10×
│ │ └── s_fca_biohub_heart_10x.h5ad
│ └── Smart-seq2
│     └── heart.h5ad
├── Leg
│ ├── 10×
│ │ └── s_fca_biohub_leg_10x.h5ad
│ └── Smart-seq2
│     └── leg.h5ad
├── MaleReproductiveGlands
│ ├── 10×
│ │ └── s_fca_biohub_male_reproductive_glands_10x.h5ad
│ └── Smart-seq2
│     └── male_reproductive_glands.h5ad
├── MalpighianTubule
│ ├── 10×
│ │ └── s_fca_biohub_malpighian_tubule_10x.h5ad
│ └── Smart-seq2
│     └── malpighian_tubule.h5ad
├── Oenocyte
│ ├── 10×
│ │ └── s_fca_biohub_oenocyte_10x.h5ad
│ └── Smart-seq2
│     └── oenocyte.h5ad
├── Ovary
│ ├── 10×
│ │ └── s_fca_biohub_ovary_10x.h5ad
│ └── Smart-seq2
│     └── ovary.h5ad
├── Proboscis
│ ├── 10×
│ │ └── s_fca_biohub_proboscis_and_maxillary_palps_10x.h5ad
│ └── Smart-seq2
│     └── proboscis_and_maxillary_palps.h5ad
├── Testis
│ ├── 10×
│ │ └── r_fca_biohub_testis_10x.h5ad
│ └── Smart-seq2
│     └── testis.h5ad
├── Trachea
│ ├── 10×
│ │ └── s_fca_biohub_trachea_10x.h5ad
│ └── Smart-seq2
│     └── trachea.h5ad
└── Wing
    ├── 10×
    │ └── s_fca_biohub_wing_10x.h5ad
    └── Smart-seq2
        └── wing.h5ad

49 directories, 32 files

```

## Trans python anndata object to R Seurat object

``s2.1_trans-anndata-to-seurat.sh``: install related packages

``s2.2_update-anndata-to-use-raw.ipynb``: to use raw if anndata has raw, for usually raw has more genes

``s2.3_trans-anndata-to-seurat.R``: use R package - schard to tran anndata object to seurat object

## Build scRNAseq database

### prepare directory

Build directories bellow, which should under shinyserver site direcotry, refer to 'Database Deployment Guide' part from [fentouxungui/SeuratExplorerServer](https://github.com/fentouxungui/SeuratExplorerServer)

```
shiny-server/
├── apps
└── index-page
```

``apps`` to save individual app for each tissue
``index-page`` to browse all apps, which has included all urls of all apps

### generate credentials file

``s3.1_generate-credentials-file.R``: to create a credentials file

after create credentials, modify the ``credentials`` parameter in ``app.R_demo`` file.

#### batch create apps

``s3.2_batch-generate-apps.R``: batch create apps for each tissue

now you can test each app by use url: ``IP address plus app directory``

in the demo: ``http://www.nibs.ac.cn:666`` is the shiny-server IP address (with port), ``FlyCellAtlas-SES/shiny-server/apps/Antenna/`` is the relative path to shiny-server site directory. The demo shiny-server site directory is set to ``/home/zhangyc/ShinyServer``.


### build index page

``app.R_index.R`` : modify ``IP_address``, ``relative_path``, ``downloaded_data_info_file``. then put it into ``index-page`` directory, and remame it to ``app.R``. This app is just for demo, you can make this app multifunctional in fact.


now you can visit index page use url: ``IP address plus index app directory``

in the demo: ``http://www.nibs.ac.cn:666`` is the shiny-server IP address (with port), ``FlyCellAtlas-SES/shiny-server/index-page/`` is the relative path to shiny-server site directory. The demo shiny-server site directory is set to ``/home/zhangyc/ShinyServer``.

## Data and codes avaliablity

all data and scripts can be downloaded from [Fly Cell Atlas - by SeuratExplorer Server](http://www.nibs.ac.cn:666/FlyCellAtlas-SES/), and the scripts can also be downloaded from github - [fentouxungui/FlyCellAtlas-SES](https://github.com/fentouxungui/SeuratExplorer)

Congratulations!