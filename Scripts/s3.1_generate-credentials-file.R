library(shinymanager)

credentials <- data.frame(
  user = "shiny",
  password = "12345",
  stringsAsFactors = FALSE
)

saveRDS(credentials, file = "credentials.rds")
print(file.path(getwd(), "credentials.rds"))