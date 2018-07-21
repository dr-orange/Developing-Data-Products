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
shinyUI(
        fluidPage(
                # Application title
                titlePanel("Health Impact of Tornado"),
                
                # Description
                tags$li("The tornado is the most harmful."),
                tags$li("Plot on the map how much tornado hurt to what region."),
                tags$li(
                        "You can see where the tornado occurred in the year selected by the slider."
                ),
                tags$li(
                        "The size of the circle is proportional to the number of people who suffered damage."
                ),
                
                hr(),
                
                # Show map
                leafletOutput("distPlot"),
                
                # Show input form
                fluidRow(column(
                        12,
                        wellPanel(
                                sliderInput(
                                        "year",
                                        NULL,
                                        min = 1950,
                                        max = 2011,
                                        value = 1979,
                                        sep = "",
                                        width = "100%"
                                ),
                                p(
                                        "The events in the database start in the year 1950 and end in November 2011. In the earlier years of the database there are generally fewer events recorded, most likely due to a lack of good records. More recent years should be considered more complete."
                                ),
                                h5("Option"),
                                checkboxInput("isALAND", label = "show ALAND", value = FALSE),
                                p("ALAND: Land Area (square meters)")
                        )
                )),
                
                # Appendix
                h3("Appendix"),
                tags$span("server.R and ui.R code on "),
                tags$a(href="https://github.com/dr-orange/Developing-Data-Products/tree/master/ShinyApplicationAndReproduciblePitch/ShinyApplication", "GitHub")
        )
)
