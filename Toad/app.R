library(shiny)
library(tidyverse)
theme_set(theme_classic(base_size = 15))

#H0-population
n_right <- 0:18
d_right <- dbinom(n_right, 18, prob = 0.5)
H0 <- data.frame(n_right, d_right)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
  titlePanel( div(column(width = 10, h2("Right-handed toads")), 
                  column(width = 2, 
                         tags$img(src = "HASlogo2012_dutch_CMYK.jpg",
                                  style = "width: 100px"))),
              windowTitle="MyPage"
  ),
  
   # Action buttons to sample populations 
   sidebarLayout(
      sidebarPanel(
        h5(paste0("Example 6.2 from The Analysis of Biological Data. ",
                  "For questions/comments: m.smits@has.nl" )),
        selectInput("pop", "Which population?",
                    choices = c("population 1", "population 2")),
        selectInput("alternative", "alternative?",
                  choices = c("<", "≠", ">")),
        actionButton("rerun", "(re)run sampling")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        plotOutput("distPlot"),
        htmlOutput(outputId = "pvalue") 
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   nright <- reactive({
     req(input$pop, input$rerun)
     if (input$pop == "population 1") {
       p=0.5
     }
     else {
       p=0.8
     }
     return(rbinom(1, 18, prob = p))
   })
   output$start_text <- renderText({
     paste0("Example 6.2 from The Analysis of Biological Data",
           "\n\nFor questions/comments, contact m.smits@has.nl")
   })
   
   alt <- reactive({
     req(input$alternative)
     alternative <- input$alternative
     if (alternative != "<"|">") {
       alternative <- "&ne;"
     }
     return(alternative)
   }) 
   
   output$distPlot <- renderPlot({
     
     colbars <- rep("grey", 19)
     
     if (input$alternative == ">") {
       colbars[(nright()+1):19] <- "green" 
       alternative <- "greater"
     }
     else if (input$alternative == "<") {
       colbars[1:(nright()+1)] <- "green"
       alternative <- "less"
     }
     else {
       d <- abs(9-nright())
       colbars[1:(10-d)] <- "green"
       colbars[(10+d):19] <- "green"
       alternative <- "two.sided"
       input$alternative == "&ne;"
     }
     
    output$pvalue <- renderText({
       fit <- binom.test(nright(), 18, p = 0.5,
                  alternative = alternative)
       paste0("H", tags$sub("0"), ": p = 0.5, H", 
              tags$sub("1"), ": p ", input$alternative, " 0.5, ",
              "P-value = ", round(fit$p.value, 4))
       })
     
  
    H0plot <-  H0 %>% 
       ggplot(aes(n_right, d_right)) +
       geom_col(color = "black", fill = colbars) +
       ylab("density") +
       xlab("number right-handed toads") +
       geom_vline(xintercept = nright(),
                  color = "Red",
                  size = 2)
    return(H0plot)
   })
   
}

# Run the application 
shinyApp(ui = ui, server = server)

