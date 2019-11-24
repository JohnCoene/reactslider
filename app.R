library(shiny)
library(reactslider)

ui <- fluidPage(
  titlePanel("reactR Input Example"),
  reactsliderInput("textInput"),
  textOutput("textOutput")
)

server <- function(input, output, session) {
  output$textOutput <- renderText({
    sprintf("You entered: %s", input$textInput)
  })
}

shinyApp(ui, server)