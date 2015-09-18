library(shiny)
library(datasets)
library(googleVis)

shinyServer(function(input, output) {
#     states <- data.frame(state.name, state.x77)
#     stateAttr <- sort(names(states),decreasing = FALSE)
#     
    datasetInput <- reactive(input$selectAttr)
    
    output$view <- renderGvis(gvisGeoChart(
        states, "state.name", datasetInput(),
        options = list(
            region = "US",
            displayMode = "regions",
            resolution = "provinces",
            width = 600, height = 400
        )
    ))
})