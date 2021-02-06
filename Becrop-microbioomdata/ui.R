ui <- fluidPage(
  navbarPage("Microbiome analyses",
    tabPanel("Kingdoms",
             sidebarPanel(
               #Upload data
               fileInput("file1", "Selecteer xxx.RDS",
                         accept = ".RDS"),
             ),
             mainPanel(plotOutput("kingdomplot"))
    ),

    tabPanel("Phylums",
             sidebarLayout(
               sidebarPanel(
                 selectInput(inputId = "Kingdom_phylum",
                             label = "Kingdom",
                             choices = "Upload eerst datafile"
                             ),
                 actionButton("button_phylum", "Update Kingdom")
               ),
               mainPanel(plotOutput("phyplot")))
    ),

    tabPanel("Classes",
             sidebarLayout(
               sidebarPanel(
                 selectInput(inputId = "Kingdom_class",
                             label = "Kingdom",
                             choices = "Upload eerst datafile"
                             ),
                 selectInput(inputId = "Phylum_class",
                             label = "Phylum",
                             choices = "Upload eerst datafile"
                             ),
                 actionButton("button_class", "Update Phylum")
               ),
               mainPanel(
                 plotOutput("classplot")
               )
             )),

    tabPanel("Orders",
             sidebarLayout(
               sidebarPanel(
                 selectInput(inputId = "Kingdom_order",
                             label = "Kingdom",
                             choices = "Upload eerst datafile"
                             ),
                 selectInput(inputId = "Phylum_order",
                             label = "Phylum",
                             choices = "Upload eerst datafile"
                             ),
                 selectInput(inputId = "Class_order",
                             label = "Class",
                             choices = "Upload eerst datafile"
                             ),
                 actionButton("button_order", "Update Class")
               ),
               mainPanel(
                 plotOutput("orderplot")
               )
             )),

    tabPanel("Families",
             sidebarLayout(
               sidebarPanel(
                 selectInput(inputId = "Kingdom_fam",
                             label = "Kingdom",
                             choices = "Upload eerst datafile"
                             ),
                 selectInput(inputId = "Phylum_fam",
                             label = "Phylum",
                             choices = "Upload eerst datafile"
                             ),
                 selectInput(inputId = "Class_fam",
                             label = "Class",
                             choices = "Upload eerst datafile"
                             ),
                 selectInput(inputId = "Order_fam",
                             label = "Order",
                             choices = "Upload eerst datafile"
                             ),
                 actionButton("button_fam", "Update Order")
               ),
               mainPanel(
                 plotOutput("famplot")
               )
             )),

    tabPanel("Genera",
             sidebarLayout(
               sidebarPanel(
                 selectInput(inputId = "Kingdom_gen",
                             label = "Kingdom",
                             choices = "Upload eerst datafile"
                             ),
                 selectInput(inputId = "Phylum_gen",
                             label = "Phylum",
                             choices = "Upload eerst datafile"
                             ),
                 selectInput(inputId = "Class_gen",
                             label = "Class",
                             choices = "Upload eerst datafile"
                             ),
                 selectInput(inputId = "Order_gen",
                             label = "Order",
                             choices = "Upload eerst datafile"
                             ),
                 selectInput(inputId = "Fam_gen",
                             label = "Family",
                             choices = "Upload eerst datafile"
                             ),
                 actionButton("button_gen", "Update Family")
               ),
               mainPanel(
                 plotOutput("genplot")
               )
             )),

#Speciestab
    tabPanel("Species",
             sidebarLayout(
               sidebarPanel(
                 selectInput(inputId = "Kingdom_spec",
                             label = "Kingdom",
                             choices = "Upload eerst datafile"
                             ),
                 selectInput(inputId = "Phylum_spec",
                             label = "Phylum",
                             choices = "Upload eerst datafile"
                             ),
                 selectInput(inputId = "Class_spec",
                             label = "Class",
                             choices = "Upload eerst datafile"
                             ),
                 selectInput(inputId = "Order_spec",
                             label = "Order",
                             choices = "Upload eerst datafile"
                             ),
                 selectInput(inputId = "Fam_spec",
                             label = "Family",
                             choices = "Upload eerst datafile"
                             ),
                 selectInput(inputId = "Gen_spec",
                             label = "Genus",
                             choices = "Upload eerst datafile"
                             ),
               ),
               mainPanel(
                 plotOutput("specplot")
               )
             ))
  )
)
