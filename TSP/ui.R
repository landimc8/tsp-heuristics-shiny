
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
