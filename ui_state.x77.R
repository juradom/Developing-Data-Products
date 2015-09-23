library(shiny)
library(datasets)
library(googleVis)

states <- data.frame(state.name, state.x77)
stateAttr <- sort(names(states),decreasing = FALSE)
shinyUI(fluidPage(titlePanel(h1(
    "1977 U.S. Census Data"
)),
fluidRow(column(
    3,
    selectInput(
        "selectAttr", label = h6("Please select an attribute:"),
        c(stateAttr)
    )
)),
mainPanel(
    htmlOutput("view")
)
))