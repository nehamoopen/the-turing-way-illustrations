#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# Inspiration: https://mastering-shiny.org/action-graphics.html
#              https://hadley.shinyapps.io/ms-puppies/
#              https://nsgrantham.shinyapps.io/tidytuesdayrocks/
#              https://github.com/nsgrantham/tidytuesdayrocks    

library(readr)
library(dplyr)
library(purrr)
library(shiny)

data <- read_csv2("data/illustrations.csv")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("The Turing Way Illustrations"),

    # Sidebar 
    sidebarLayout(
        sidebarPanel(
            selectInput("name", "name", data$name)
        ),

        # Show image
        mainPanel(
           imageOutput("illustration")
        )
    )
)

# Define server logic 
server <- function(input, output, session) {
  
    selection <- reactive({
      data %>%
        filter(name == input$name)
    })

    output$illustration <- renderImage({
        # generate bins based on input$bins from ui.R
      list(
        src = selection()$path,
        contentType = "image/jpeg",
        width = "100%",
        height = "auto"
      )
    }, deleteFile = FALSE)
}
# Run the application 
shinyApp(ui = ui, server = server)
