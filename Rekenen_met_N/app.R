library(shiny)
library(e1071)

histsom <- function(A_m,A_s,B_m,B_s) {
  
     A <- rnorm(1000, mean=A_m, sd=A_s)
     B <- rnorm(1000, mean=B_m, sd=B_s)
     return(A+B)
}

histmin <- function(A_m,A_s,B_m,B_s) {
  
     A <- rnorm(1000, mean=A_m, sd=A_s)
     B <- rnorm(1000, mean=B_m, sd=B_s)
     return(A-B)
}

histkeer <- function(A_m,A_s,B_m,B_s) {
  
     A <- rnorm(1000, mean=A_m, sd=A_s)
     B <- rnorm(1000, mean=B_m, sd=B_s)
     return(A*B)
}

histdeel <- function(A_m,A_s,B_m,B_s) {
  
     A <- rnorm(1000, mean=A_m, sd=A_s)
     B <- rnorm(1000, mean=B_m, sd=B_s)
     return(A/B)
}

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   titlePanel("Rekenen met de normale verdeling"),
   
   sidebarLayout(
      sidebarPanel(
         numericInput("A_m", "A: gemiddelde",
                     value = 10),
      numericInput("A_s", "A: stdev",
                   value = 2),
      numericInput("B_m", "B: gemiddelde",
                   value = 10),
      numericInput("B_s", "B: stdev.",
                   value = 2),
      selectInput("berekening", "Kies berekening:",
                  choices = c("A+B","A-B","A*B","A:B"))
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distplot"),
        tableOutput("ndata")

      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  C <- reactive({
    if(input$berekening=="A+B") {
    histsom(input$A_m, input$A_s, input$B_m, input$B_s)
    }
    else if(input$berekening=="A-B") {
    histmin(input$A_m, input$A_s, input$B_m, input$B_s)
    }
    else if(input$berekening=="AxB") {
    histkeer(input$A_m, input$A_s, input$B_m, input$B_s)
    }
    else{
    histdeel(input$A_m, input$A_s, input$B_m, input$B_s)
    }
  })
  
  output$distplot <- renderPlot({
    hist(C())
  })
  
  output$ndata <- renderTable({
   data.frame(Gemiddelde = mean(C()),
               Stdev = sd(C()),
                 Var = var(C()),
               kurtosis = kurtosis(C(), type=2),
               Skewness = skewness(C(), type=2))
  }) 
          
}

# Run the application 
shinyApp(ui = ui, server = server)

