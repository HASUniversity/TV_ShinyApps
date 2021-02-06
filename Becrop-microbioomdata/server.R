server <- function(session, input, output) {

#Read import file
  df <- reactive({
    req(input$file1)
    readRDS(input$file1$datapath)
  })

  observeEvent(df(), {
    for(i in paste("Kingdom", add_levels, sep = "_")) {
      updateSelectInput(session, i, choices = unique(df()$Kingdom))
    }
    for(i in paste("Phylum", tail(add_levels, -1), sep = "_")) {
      updateSelectInput(session, i, choices = unique(df()$Phylum))
    }
    for(i in paste("Class", tail(add_levels, -2), sep = "_")) {
      updateSelectInput(session, i, choices = unique(df()$Class))
    }
    for(i in paste("Order", tail(add_levels, -3), sep = "_")) {
      updateSelectInput(session, i, choices = unique(df()$Orden))
    }
    for(i in paste("Family", tail(add_levels, -4), sep = "_")) {
      updateSelectInput(session, i, choices = unique(df()$Family))
    }
    for(i in paste("Genus", tail(add_levels, -5), sep = "_")) {
      updateSelectInput(session, i, choices = unique(df()$Genus))
    }
    for(i in paste("Species", tail(add_levels, -5), sep = "_")) {
      updateSelectInput(session, i, choices = unique(df()$Genus))
    }
  })


#Observe Phylum
  observe({
    updateSelectInput(session,
                      inputId = "Phylum_class",
                      choices = unique(df()$Phylum[df()$Kingdom == input$Kingdom_class]))
  })

#Observe Order
  observe({
    updateSelectInput(session,
                      inputId = "Phylum_order",
                      choices = unique(df()$Phylum[df()$Kingdom == input$Kingdom_order]))
  })

  observe({
    updateSelectInput(session,
                      inputId = "Class_order",
                      choices = unique(df()$Class[df()$Phylum == input$Phylum_order]))
  })

#Observe Family
  observe({
    updateSelectInput(session,
                      inputId = "Phylum_fam",
                      choices = unique(df()$Phylum[df()$Kingdom == input$Kingdom_fam]))
  })

  observe({
    updateSelectInput(session,
                      inputId = "Class_fam",
                      choices = unique(df()$Class[df()$Phylum == input$Phylum_fam]))
  })

  observe({
    updateSelectInput(session,
                      inputId = "Order_fam",
                      choices = unique(df()$Orden[df()$Class == input$Class_fam]))
  })

#Observe Genus
  observe({
    updateSelectInput(session,
                      inputId = "Phylum_gen",
                      choices = unique(df()$Phylum[df()$Kingdom == input$Kingdom_gen]))
  })

  observe({
    updateSelectInput(session,
                      inputId = "Class_gen",
                      choices = unique(df()$Class[df()$Phylum == input$Phylum_gen]))
  })

  observe({
    updateSelectInput(session,
                      inputId = "Order_gen",
                      choices = unique(df()$Orden[df()$Class == input$Class_gen]))
  })

  observe({
    updateSelectInput(session,
                      inputId = "Fam_gen",
                      choices = unique(df()$Family[df()$Orden == input$Order_gen]))
  })

#Observe Species
  observe({
    updateSelectInput(session,
                      inputId = "Phylum_spec",
                      choices = unique(df()$Phylum[df()$Kingdom == input$Kingdom_spec]))
  })

  observe({
    updateSelectInput(session,
                      inputId = "Class_spec",
                      choices = unique(df()$Class[df()$Phylum == input$Phylum_spec]))
  })

  observe({
    updateSelectInput(session,
                      inputId = "Order_spec",
                      choices = unique(df()$Orden[df()$Class == input$Class_spec]))
  })

  observe({
    updateSelectInput(session,
                      inputId = "Fam_spec",
                      choices = unique(df()$Family[df()$Orden == input$Order_spec]))
  })

  observe({
    updateSelectInput(session,
                      inputId = "Gen_spec",
                      choices = unique(df()$Genus[df()$Family == input$Fam_spec]))
  })



#Updatebutton
  #Update Kingdom
  observeEvent(input$button_phylum, {
  for(id in paste("Kingdom", add_levels, sep = "_")) {
    updateSelectInput(session,
                      inputId = id,
                      selected = input$Kingdom_phylum)
  }
  })


  #Update Phylum
  observeEvent(input$button_class, {
    for(id in paste("Kingdom", add_levels, sep = "_")) {
      updateSelectInput(session,
                        inputId = id,
                        selected = input$Kingdom_class)
    }
    for(id in paste("Phylum", tail(add_levels, -1), sep = "_")) {
      updateSelectInput(session,
                        inputId = id,
                        selected = input$Phylum_class)
    }
  })

  #Update class
  observeEvent(input$button_order, {
    for(id in paste("Kingdom", add_levels, sep = "_")) {
      updateSelectInput(session,
                        inputId = id,
                        selected = input$Kingdom_order)
    }
    for(id in paste("Phylum", tail(add_levels, -1), sep = "_")) {
      updateSelectInput(session,
                        inputId = id,
                        selected = input$Phylum_order)
    }
    for(id in paste("Class", tail(add_levels, -2), sep = "_")) {
      updateSelectInput(session,
                        inputId = id,
                        selected = input$Class_order)
    }
  })

  #Update order
  observeEvent(input$button_fam, {
    for(id in paste("Kingdom", add_levels, sep = "_")) {
      updateSelectInput(session,
                        inputId = id,
                        selected = input$Kingdom_fam)
    }
    for(id in paste("Phylum", tail(add_levels, -1), sep = "_")) {
      updateSelectInput(session,
                        inputId = id,
                        selected = input$Phylum_fam)
    }
    for(id in paste("Class", tail(add_levels, -2), sep = "_")) {
      updateSelectInput(session,
                        inputId = id,
                        selected = input$Class_fam)
    }
    for(id in paste("Order", tail(add_levels, -3), sep = "_")) {
      updateSelectInput(session,
                        inputId = id,
                        selected = input$Order_fam)
    }
  })

  #Update genus
  observeEvent(input$button_gen, {
    for(id in paste("Kingdom", add_levels, sep = "_")) {
      updateSelectInput(session,
                        inputId = id,
                        selected = input$Kingdom_gen)
    }
    for(id in paste("Phylum", tail(add_levels, -1), sep = "_")) {
      updateSelectInput(session,
                        inputId = id,
                        selected = input$Phylum_gen)
    }
    for(id in paste("Class", tail(add_levels, -2), sep = "_")) {
      updateSelectInput(session,
                        inputId = id,
                        selected = input$Class_gen)
    }
    for(id in paste("Order", tail(add_levels, -3), sep = "_")) {
      updateSelectInput(session,
                        inputId = id,
                        selected = input$Order_gen)
    }
    for(id in paste("Family", tail(add_levels, -4), sep = "_")) {
      updateSelectInput(session,
                        inputId = id,
                        selected = input$Family_gen)
    }
  })


#Figuren

  output$kingdomplot <- renderPlot(
  bargraph(df(), "Kingdom", "Percentage", "behandeling")
  )

  output$phyplot <- renderPlot(
  bargraph(df() %>% filter(Kingdom == input$Kingdom_phylum),
                  "Phylum", "Percentage", "behandeling")
  )

  output$classplot <- renderPlot(
    bargraph(df() %>% filter(Phylum == input$Phylum_class),
                      "Class", "Percentage", "behandeling")
  )

  output$orderplot <- renderPlot(
    bargraph(df() %>% filter(Class == input$Class_order),
                    "Orden", "Percentage", "behandeling")
  )

  output$famplot <- renderPlot(
    bargraph(df() %>% filter(Orden == input$Order_fam),
                    "Family", "Percentage", "behandeling")
  )

  output$genplot <- renderPlot(
    bargraph(df() %>% filter(Family == input$Fam_gen),
                    "Genus", "Percentage", "behandeling")
  )

  output$specplot <- renderPlot(
    bargraph(df() %>% filter(Genus == input$Gen_spec),
                    "Species", "Percentage", "behandeling")
  )

}

