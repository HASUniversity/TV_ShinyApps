#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


histsom <- function(A_m,A_s,B_m,B_s) {
  
     A <- rnorm(1000, mean=A_m, sd=A_s)
     B <- rnorm(1000, mean=B_m, sd=B_s)
     return(hist(A+B))
}

histmin <- function(A_m,A_s,B_m,B_s) {
  
     A <- rnorm(1000, mean=A_m, sd=A_s)
     B <- rnorm(1000, mean=B_m, sd=B_s)
     return(hist(A-B))
}

histkeer <- function(A_m,A_s,B_m,B_s) {
  
     A <- rnorm(1000, mean=A_m, sd=A_s)
     B <- rnorm(1000, mean=B_m, sd=B_s)
     return(hist(A*B))
}

histdeel <- function(A_m,A_s,B_m,B_s) {
  
     A <- rnorm(1000, mean=A_m, sd=A_s)
     B <- rnorm(1000, mean=B_m, sd=B_s)
     return(hist(A/B))
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
#         plotOutput("distPlot")
        plotOutput("histsom")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$histsom <- renderPlot({
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
   
#   output$histsom <- renderPlot({
#     A_m <- input$A_m
#     A_s <- input$A_s
#     B_m <- input$B_m
#     B_s <- input$B_s
     
#     A <- rnorm(1000, mean=A_m, sd=A_s)
#     B <- rnorm(1000, mean=B_m, sd=B_s)
#     distPlot <- hist(A+B)
#     hist(A+B)
          
#   })
}

# Run the application 
shinyApp(ui = ui, server = server)

