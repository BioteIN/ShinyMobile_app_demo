tabText2 <- "bal bal bla "

segmentacao_tab <- bs4TabItem(
  tabName = "segmentacao",
  uiOutput("segmentacao_UI") %>% withSpinner(),
  
  tabText2
)

