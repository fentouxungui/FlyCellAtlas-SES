#!/usr/bin/env Rscript
library(shiny)
library(shinydashboard)
library(DT)
library(dplyr)

IP_address <- 'http://www.nibs.ac.cn:666'
relative_path <- 'FlyCellAtlas-SES/shiny-server/apps'


downloaded_data_info_file <- '~/ShinyServer/FlyCellAtlas-SES/Scripts/Download-FlyCellAtlas.csv'
# Load index data
indexData <- read.csv(downloaded_data_info_file, stringsAsFactors = FALSE)
indexData <- indexData[indexData$Tissue != '', ]
indexData <- group_by(indexData, Tissue) %>% 
  summarise(library = paste(Library, collapse = ';'), 
            OfficialLink.SCope = OfficialLink.SCope[1],
            OfficialLink.ASAP = OfficialLink.ASAP[1])
indexData$Data.Link <- file.path(IP_address, relative_path, indexData$Tissue)

# Helper function to create links
create_links <- function(urls, label = "View") {
  sapply(urls, function(url) {
    if (url %in% c("", "-", NA)) {
      return("-")
    }
    links <- unlist(strsplit(url, ";"))
    link_tags <- paste0(
      '<a href="', links, '" target="_blank">', label, '</a>'
    )
    paste(link_tags, collapse = "<br>")
  }, USE.NAMES = FALSE)
}

# Create links
indexData$Data.Link <- create_links(indexData$Data.Link, "View Data")
indexData$OfficialLink.SCope <- create_links(indexData$OfficialLink.SCope, "External")
indexData$OfficialLink.ASAP <- create_links(indexData$OfficialLink.ASAP, "External")

# UI
ui <- dashboardPage(
  title = "Fly Cell Atlas by SeuratExplorer Server",
  dashboardHeader(
    title = strong("Fly Cell Atlas"),
    titleWidth = 280
  ),
  dashboardSidebar(
    width = 280,
    sidebarMenu(
      menuItem(strong("Browse Data"), tabName = "data", icon = icon("database"))
    )
  ),
  dashboardBody(
    tags$style(HTML("@import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css');")),
    tabItems(
      tabItem(
        tabName = "data",
        fluidRow(
          box(
            title = "Available Datasets",
            width = 12,
            status = "primary",
            solidHeader = TRUE,
            DT::dataTableOutput("dataTable")
          )
        )
      )
    )
  )
)

# Server
server <- function(input, output, session) {
  # Render table
  output$dataTable <- DT::renderDataTable({
    DT::datatable(
      indexData,
      escape = FALSE,
      options = list(
        pageLength = 15,
        scrollX = TRUE,
        order = list(list(1, 'asc'))
      )
    )
  })
}

shinyApp(ui, server)
