

#Criar reatives

topup_filter_tbl <- reactive({
  
  result <- topup_dat %>% filter(between(CREATED_AT, input$dateRange[1], input$dateRange[2]))
  
  return(result)
  
})

# 3.0 manipulacao de dados ------------------------------------------------

total.revenue <- reactive({
  
  sum(topup_filter_tbl()$AMOUNT)
  
})


sales.account <-  reactive({ topup_filter_tbl() %>% group_by(CREATED_AT) %>% summarise(value = sum(QYT)) %>% filter(value==max(value))})

prof.prod <- reactive({topup_filter_tbl() %>% group_by(format(CREATED_AT, "%m")) %>% summarise(value = sum(AMOUNT)) %>% filter(value==max(value))})

day.rec <- reactive({topup_filter_tbl() %>% group_by(format(CREATED_AT, "%m")) %>% summarise(value = sum(AMOUNT)) %>% filter(value==max(value))})

v1 <- topup_dat %>% group_by(CREATED_AT) %>% summarise(value = sum(QYT)) %>% filter(value==max(value))


#conteudo reactives ------------------
frow_rec1 <- fluidRow(
  bs4ValueBox(
    value = v1,
    subtitle = "New orders",
    status = "primary",
    icon = "shopping-cart",
    href = "#"
  ),
  bs4ValueBox(
    value = 150,
    subtitle = "New orders",
    status = "primary",
    icon = "shopping-cart",
    href = "#"
  ),
  bs4ValueBox(
    value = 150,
    subtitle = "New orders",
    status = "primary",
    icon = "shopping-cart",
    href = "#"
  )
)


# 2.0 Graficos ------------------------------------------------------------

output$revenuebyPrd <- renderPlot({
  ggplot(data = topup_filter_tbl(), 
         aes(x=CREATED_AT, y=AMOUNT, fill=factor(SEGMENTATION_ID))) + 
    geom_bar(position = "dodge", stat = "identity") + ylab("Valor (em Meticais)") + 
    xlab("Data") + theme(legend.position="bottom" 
                         ,plot.title= element_text(size=15, face="bold")) + 
    ggtitle("Valor das Vendas por data") + labs(fill = "Tipo")
})


output$revenuebyRegion <- renderPlot({
  ggplot(data = topup_filter_tbl(), 
         aes(x=SEGMENTATION_ID, y=AMOUNT, fill=factor(SEGMENTATION_ID))) + 
    geom_bar(position = "dodge", stat = "identity") + ylab("Valor (em Meticais)") + 
    xlab("Tipo de Recarga") + theme(legend.position="bottom" 
                                    ,plot.title= element_text(size=15, face="bold")) + 
    ggtitle("Valor das Vendas por tipo") + labs(fill = "Tipo")
})


frow2 <- fluidRow(
  
  box(
    title = "Vendas por Datas"
    ,status = "primary"
    ,solidHeader = TRUE 
    ,collapsible = TRUE 
    ,plotOutput("revenuebyPrd", height = "300px")
  )
  
  ,box(
    title = "Vendas pelo tipo de recargas"
    ,status = "primary"
    ,solidHeader = TRUE 
    ,collapsible = TRUE 
    ,plotOutput("revenuebyRegion", height = "300px")
  ) 
  
)

frow3 <- tabItem(tabName = "item_2",
                 h2(" ")
)




output$recarregamento_UI <- renderUI({
  
  
  tagList(
    frow_rec1,
    frow2,
    frow3
    
  )
})

