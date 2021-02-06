library(shiny)
library(readxl)
library(tidyverse)
theme_set(theme_classic(base_size = 15))

#df <- read_excel("../Kunstmestvrij Telen (vanderborne)/Data/microbioom_omgezet.xlsx")

bargraph <- function(df, x,y,g) {
  df %>%
    ggplot(aes(!!sym(x), !!sym(y), fill = !!sym(g))) +
    stat_summary(fun = "sum",
                 geom = "bar",
                 position = position_dodge2(preserve = "single",
                                            padding = 0)) +
    theme(axis.text.x = element_text(angle = 45,
                                     vjust = 0.5,
                                     hjust = 0.5),
          axis.title.x = element_blank())
}


#Update taxonomic levels
v_levels <- c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus")
add_levels <- c("phylum", "class", "order", "fam", "gen", "spec")

