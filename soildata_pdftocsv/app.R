source("labpdfreader.R")
library(shiny)
library(readxl)

#Get parameterdata
param <- read_excel("parameters.xlsx") %>% 
  select(name, search, row, RE, lab)


ui <- fluidPage(
    titlePanel( div(column(width = 10, h2("PDF-to-CSV for soil analyses")), 
                    column(width = 2, 
                           tags$img(src = "HASlogo2012_dutch_CMYK.jpg",
                                    style = "width: 100px"))),
                windowTitle="MyPage"
    ),
  
   
   sidebarLayout(
      sidebarPanel(
        selectInput("lab", "Which lab?", choices = unique(param$lab)),
        fileInput("filelist", "pdf-files", multiple = TRUE, 
                  accept = "*.pdf|*.PDF"),
        downloadButton("downloadData", "Download")
      ),
      
     
      mainPanel(
        p("With this app you can extract data from soil analyses,
        in pdf-format from the main Dutch labs."),
        p("The output format is csv."),
        p("For questions, comments or requests: send an email to m.smits@has.nl."),
        verbatimTextOutput(outputId = "tekst")
      )
   )
)

server <- function(session, input, output) {
  
    param_lab <- reactive({
      req(input$lab)
      param %>% filter(lab == input$lab)
    })
    
    df <- reactive({
      req(input$filelist)  
      getlabdata2(Lab = input$lab, 
                  datapaths = input$filelist$datapath,
                  datanames = input$filelist$name, 
                  param = param_lab())
    })
    
    output$starttekst <- renderText({
        paste0("With this app you can extract data from soil analyses\n",
        "in pdf-format from the main Dutch labs.\n\n",
        "The output format is csv.\n\n",
        "For questions, comments or requests:\n send an email to m.smits@has.nl")
    })
    
    output$tekst <- renderText({
      if (!length(input$filelist$datapath)>0) {"Status: Choose lab and pdf file(s)"}
      else ("Status: Download results. \nIf needed select other files and/or lab.")
    })
   
    output$downloadData <- downloadHandler(
        filename = function() {
          paste0("labdata", Sys.Date(), ".csv")
        },
        content = function(file) {
          write.csv(df(), file)
        }
        )
}

# Run the application 
shinyApp(ui = ui, server = server)

