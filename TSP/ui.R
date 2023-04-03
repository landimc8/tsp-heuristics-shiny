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
library(mapview)


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  titlePanel("Mapshot error example"),
  
  sidebarLayout(
    sidebarPanel(
      actionButton("addMarkers", "Add markers"),
      actionButton("saveMapUsingID", "Screenshot map with ID"),
      actionButton("saveMapUsingProxy", "Screenshot map with Proxy")
    ),
    mainPanel(
      leafletOutput("map")
    )
  )
)
