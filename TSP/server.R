server <- function(input, output, session) {
  
  cities_to_visit <- reactive(input$citychoices)
  Optimal_journ_1 <- reactive(decision_with_map(cities_to_visit(), seed_value = 1240))
  map <- reactive(function_cart_graph(datf=Optimal_journ_1()[[2]]))
  n <- reactive(input$n_t)
  Optimal_journ_2 <- reactive(Decision(Mat_distance = input$w[1:n(),1:n()], seed_value = 1240))
  
  hm <- reactive(as.numeric(input$hm))
  resrch <- reactive(research(m=hm()[2], h=hm()[1], seed_value=inputsdval, sim_param=input$sparam))
  
  
  output$Optimal_Journey_1 <- renderPrint(Optimal_journ_1()[[1]])
  output$min_dist_1 <- renderPrint(Optimal_journ_1()[[3]])
  output$map_journey <- renderLeaflet(map())
  
  output$Optimal_Journey_2 <- renderPrint(Optimal_journ_2()[[3]][[2]])
  output$min_dist_2 <- renderPrint(Optimal_journ_2()[[3]][[1]])
  
  Pval=reactive(resrch()[[9]])
  resmat=reactive(cbind(resrch()[[1]],p_value=Pval()))
  
  Pval_21=reactive(resrch()[[10]])
  resmat_21=reactive(cbind(resrch()[[2]], p_value_21=Pval_21()))
  
  Pval_43=reactive(resrch()[[11]])
  resmat_43=reactive(cbind(resrch()[[3]], p_value_43=Pval_43()))
  
  Pval_41=reactive(resrch()[[12]])
  resmat_41=reactive(cbind(resrch()[[4]], p_value_41=Pval_41()))
  
  Pval_32=reactive(resrch()[[13]])
  resmat_32=reactive(cbind(resrch()[[5]], p_value_32=Pval_32()))
  
  Pval_31=reactive(resrch()[[14]])
  resmat_31=reactive(cbind(resrch()[[6]], p_value_31=Pval_31()))
  
  Pval_42=reactive(resrch()[[15]])
  resmat_42=reactive(cbind(resrch()[[7]], p_value_42=Pval_42()))
  
  Pval_m=reactive(resrch()[[16]])
  resmat_m=reactive(cbind(resrch()[[8]], p_value_m=Pval_m()))
  
  output$perct <- renderTable(resmat(), rownames = TRUE, colnames = TRUE)
  output$perct21 <- renderTable(resmat_21(), rownames = TRUE, colnames = TRUE)
  output$perct43 <- renderTable(resmat_43(), rownames = TRUE, colnames = TRUE)
  output$perct41 <- renderTable(resmat_41(), rownames = TRUE, colnames = TRUE)
  output$perct32 <- renderTable(resmat_32(), rownames = TRUE, colnames = TRUE)
  
  output$inter_parity1_g <- renderText(c(resrch()[[17]]))
  output$inter_parity2_g <- renderText(c(resrch()[[18]]))
  
  output$inter_parity1_21 <- renderText(c(resrch()[[19]]))
  output$inter_parity2_21 <- renderText(c(resrch()[[20]]))
  
  output$inter_parity1_43 <- renderText(c(resrch()[[21]]))
  output$inter_parity2_43 <- renderText(c(resrch()[[22]]))
  
  output$inter_parity1_41 <- renderText(c(resrch()[[23]]))
  output$inter_parity2_41 <- renderText(c(resrch()[[24]]))
  
  output$inter_parity1_32 <- renderText(c(resrch()[[25]]))
  output$inter_parity2_32 <- renderText(c(resrch()[[26]]))
  
  output$inter_myopia1_31 <- renderText(c(resrch()[[27]]))
  output$inter_myopia2_31 <- renderText(c(resrch()[[28]]))
  
  output$inter_myopia1_42 <- renderText(c(resrch()[[29]]))
  output$inter_myopia2_42 <- renderText(c(resrch()[[30]]))
  
  output$inter_myopia1_mg <- renderText(c(resrch()[[31]]))
  output$inter_myopia2_mg <- renderText(c(resrch()[[32]]))
  
  output$inter_parity_1 <- renderText(c(resrch()[[33]]))
  output$inter_parity_2 <- renderText(c(resrch()[[34]]))
  output$inter_parity_3 <- renderText(c(resrch()[[38]]))
  output$inter_myopia_1 <- renderText(c(resrch()[[35]]))
  output$inter_myopia_2 <- renderText(c(resrch()[[36]]))
  output$inter_myopia_3 <- renderText(c(resrch()[[37]]))
  
  
  output$perctm <- renderTable(resmat_m(), rownames = TRUE, colnames = TRUE)
  output$perct31 <- renderTable(resmat_31(), rownames = TRUE, colnames = TRUE)
  output$perct42 <- renderTable(resmat_42(), rownames = TRUE, colnames = TRUE)
  output$inter_myopia <- renderPrint(interpret)
  
}

