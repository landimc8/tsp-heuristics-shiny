
# Set Google Maps API key
register_google(key = "AIzaSyBh9zrJR1Lbtuxp4lCNyGmbo9kcw1odi3I")

# Define server
server <- function(input, output, session) {
  output$map <- renderLeaflet({
    leaflet() %>%
      setView(lng = mean(cities$lon), lat = mean(cities$lat), zoom = 3) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addMarkers(data = cities, 
                 icon = city_icon,
                 label = ~name,
                 labelOptions = labelOptions(noHide = TRUE, textOnly = TRUE),
                 clusterOptions = markerClusterOptions()) %>%
      addMarkers(data = airplanes_sf,
                 icon = airplane_icon,
                 popup = "Airplane")
  })
  
  observeEvent(input$city, {
    selected_city <- subset(cities, name == input$city)
    leafletProxy("map") %>%
      setView(lng = selected_city$lon, lat = selected_city$lat, zoom = 12)
  })
}