#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)

# Define UI for application that draws a map
shinyUI(fluidPage(
        # Application title
        titlePanel("Health Impact of Tornado"),
        
        # Show a plot of the generated distribution
        leafletOutput("distPlot"),

        hr(),
        
        fluidRow(column(
                9,
                sliderInput(
                        "year",
                        "Year:",
                        min = 1950,
                        max = 2011,
                        value = 2006,
                        sep = "",
                        width = "100%"
                )
        ), column(3, h4("Options"), checkboxInput("isALAND", label = "show ALAND", value = FALSE)))
))
