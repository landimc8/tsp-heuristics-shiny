#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram

server <- function(input, output) {
  
  output$map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$OpenStreetMap)
  })
  
  observeEvent(input$addMarkers, {
    # Somewhere in London
    randPoint1 <- runif(1, min=-0.34, max=0.16)
    randPoint2 <- runif(1, min=51.34, max=51.67)
    leafletProxy("map") %>%
      addMarkers(lng=randPoint1, lat=randPoint2) %>%
      setView(lng=randPoint1, lat=randPoint2, zoom=10)
  })
  
  observeEvent(input$saveMapUsingID, {
    mapshot("map", file=paste0(getwd(), '/exported_map.png'))
  })
  
  observeEvent(input$saveMapUsingProxy, {
    m <- leafletProxy("map")
    mapshot(m, file=paste0(getwd(), '/exported_map.png'))
  })
  
}
