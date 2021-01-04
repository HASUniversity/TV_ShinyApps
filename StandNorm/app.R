library(shiny)
library(tidyverse)
theme_set(theme_classic(base_size = 15))

#Standaard normale verdeling maken
z <- (-50:50)/10
d <- dnorm(z)
df <- data.frame(z, d)

#Figuur maken
g <- df %>% 
  ggplot(aes(z, d)) +
  geom_line(color = "blue", size = 2) +
  xlab("Z") +
  ylab("Dichtheid")



# Define UI for application that draws a histogram
ui <- fluidPage(
   
   titlePanel("Standaardiseren van de normale verdeling"),
   
   sidebarLayout(
      sidebarPanel(
         numericInput("x_mean", "A: gemiddelde",
                     value = 540),
      numericInput("x_sd", "A: stdev",
                   value = 5),
      numericInput("x_min", "Gewicht > ...",
                   value = 542),
      numericInput("x_max", "Gewicht < ...",
                   value = +545)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distplot"),
         textOutput("P"),
         tags$style(type = "text/css", "#P {white-space: pre-wrap;")
  
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  zmin <- reactive({
    (input$x_min-input$x_mean)/input$x_sd
  })
  
  zmax <- reactive({
    (input$x_max-input$x_mean)/input$x_sd
  })
  
  output$distplot <- renderPlot({
    g + 
      scale_x_continuous(sec.axis = sec_axis(~.*input$x_sd+input$x_mean, 
                                                    name = "Gewicht")) +
      geom_vline(xintercept = zmin(), color = "red", size = 2) +
      geom_vline(xintercept = zmax(), color = "red", size = 2) +
      geom_area(aes(y = ifelse(z>zmin() & z<zmax() , d, 0)),
                        fill = "blue", alpha = 0.2)
  })
  
  output$P <- renderText({
    p <- 1-pnorm(zmin())-pnorm(-zmax())
    line1 <- paste0("P(", input$x_min, " < ", "Gewicht", "< ", input$x_max, ")")
    line2 <- paste0("P(", zmin(), " < ", "Z", " < ", zmax(), ")")
    line3 <- paste0("P = ", round(p, 4))
    print(paste(line1, line2, line3, sep = "\n"))
  })
}


# Run the application 
shinyApp(ui = ui, server = server)

