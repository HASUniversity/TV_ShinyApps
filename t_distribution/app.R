library(shiny)
library(tidyverse)
theme_set(theme_classic(base_size = 15))

ui <- fluidPage(
   
   # Application title
  titlePanel( div(column(width = 10, h2("Effect sample size on estimated variation")), 
                  column(width = 2, 
                         tags$img(src = "HASlogo2012_dutch_CMYK.jpg",
                                  style = "width: 100px"))),
              windowTitle="MyPage"
  ),
  
   # Action buttons to sample populations 
   sidebarLayout(
      sidebarPanel(
        numericInput("mu", "Population mean", value = 540),
        numericInput("sigma", "Population standard deviation", 40),
        numericInput("n", "Sample size", value = 25),
        actionButton("r", "Run")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        plotOutput("distPlot")
     #   htmlOutput(outputId = "estimates") 
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    input$r
    s <- isolate(replicate(10000,
                     sd(rnorm(input$n, input$mu, input$sigma))))
     isolate(tibble(s) %>% 
         ggplot(aes(x = s)) +
           geom_histogram(color = "black", fill = "grey", bins = 30) +
           geom_vline(xintercept = input$sigma, color = "red", size = 1.5) +
           xlab("estimated standard deviation"))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
