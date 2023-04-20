
# Define UI

library(shiny)
library(leaflet)

#Define UI
ui <- fluidPage(
  titlePanel("Pin a Location on the Map"),
  
  tags$head(
    tags$link(rel = "stylesheet", href =
                "https://cdn.jsdelivr.net/gh/Leaflet/Leaflet.label/dist/leaflet.label.css"),
    tags$script(src =
                  "https://cdn.jsdelivr.net/gh/Leaflet/Leaflet.label/dist/leaflet.label.js")
  ),
  
  #using Javascript to geolocate the user
  
  tags$script('
              $(document).on("shiny:connected", function() {
              navigator.geolocation.getCurrentPosition(function(position) {
              Shiny.onInputChange("userLocation", [position.coords.latitude, position.coords.longitude]);
              });
            });
          '),
  
  leafletOutput("map"),
  selectInput("location", "Select a Location:",
              c("USA", "Canada", "Mexico", "Brazil", "Argentina",
                "UK", "France", "Germany", "Italy", "Spain",
                "China", "Japan", "India", "Australia", "New Zealand",
                "Tokyo", "New York", "London", "Paris", "Berlin"),
              multiple = TRUE),
  actionButton("goButto", "Find Best Route"),
  textOutput("calculating"),
  textOutput("route"),
  
  verbatimTextOutput("error")
)
