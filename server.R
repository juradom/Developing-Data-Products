library(shiny)
library(datasets)
library(googleVis)

# Extract data from usda.gov
if(!file.exists("/data/InternationalFoodConsumption.csv")){
    fileURL1 <- "http://www.ers.usda.gov/datafiles/International_Food_Consumption_Patterns/Zip_File_Containing_1996_Data_in_CSV_and_TXT_format/ifcdata.zip"
    download.file(fileURL1, dest="InternationalFoodConsumption.zip",method="curl") 
    unzip("InternationalFoodConsumption.zip")
}

# read csv
foodData <- read.csv("InternationalFoodConsumption.csv"
                     ,header=TRUE
                     ,na.strings=c("", "NA"))

# subset data for Food Budget Shares Only
budget <- subset(foodData[which(foodData$Category=='Food budget shares for 114 countries'),])




# pivot data
budgetPivot <- cast(budget,Country ~ CommodityName)
shinyServer(function(input, output) {
    
    datasetInput <- reactive(input$selectCategory)
    
    output$view <- renderGvis(gvisGeoChart(
        budgetPivot, "Country", datasetInput(),
        options = list(
            colorAxis = "{colors:['green','yellow','orange','red']}"
            )
    ))
    output$dynamicTitle <- renderText({paste("Food Budget Shares For"
                                       ,toupper(input$selectCategory)
                                       ,"By Country (1996)")})
    
})