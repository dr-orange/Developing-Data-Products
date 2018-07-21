#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(dplyr)

tornadoDataFilePath <- file.path(".", "tornadoData.rda")

if(!file.exists(tornadoDataFilePath)) {
        download.file(
                "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2",
                destfile = "repdata-data-StormData.csv.bz2"
        )
        stormData <-
                read.csv("repdata-data-StormData.csv.bz2",
                         header = TRUE,
                         stringsAsFactors = FALSE)
        tornadoData <- stormData %>%
                filter(EVTYPE == "TORNADO") %>%
                # fatalities and injuries
                mutate(
                        BGN_DATE = as.POSIXct(BGN_DATE, format = "%m/%d/%Y %H:%M:%S"),
                        PERSONS = FATALITIES + INJURIES,
                        LATITUDE = LATITUDE / 100,
                        LONGITUDE = -LONGITUDE / 100
                ) %>%
                filter(PERSONS > 10) %>%
                select(BGN_DATE, PERSONS, LATITUDE, LONGITUDE)
        
        save(tornadoData, file = tornadoDataFilePath)
} else {
        load(tornadoDataFilePath)
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        output$distPlot <- renderLeaflet({
                # data frame on input$year from ui.R
                tornadoDataOfYear <- tornadoData %>%
                        filter(BGN_DATE >= paste0(input$year, "-01-01") &
                                       BGN_DATE <= paste0(input$year, "-12-31"))
                
                # draw the map with the specified year
                leaflet(tornadoDataOfYear) %>%
                        addTiles() %>%
                        addCircles(
                                lng = ~ LONGITUDE,
                                lat = ~ LATITUDE,
                                weight = 1,
                                radius = ~ sqrt(PERSONS) * 5000
                        ) %>%
                        setView(-87.03, 36.09, 5)
        })
})

