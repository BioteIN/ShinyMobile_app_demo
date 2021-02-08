tabText1 <- "hello bs4dash here"

recarregamento_tab <- bs4TabItem(
  tabName = "recarregamento",
  uiOutput("recarregamento_UIo") %>% withSpinner(),
  
  tabText1
)

