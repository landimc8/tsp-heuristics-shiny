
# Define UI for app that draws a map with airplanes and selectable cities
ui <- fluidPage(
  
  # App title
  titlePanel("Airplanes and Cities Map"),
  
  # Sidebar with city selection
  sidebarLayout(
    sidebarPanel(
      selectInput("cities", "Select Cities:",
                  choices = c("Mountain View, CA", "Paris, France", "London, UK", "New York, NY"),
                  selected = c("Mountain View, CA", "Paris, France"),
                  multiple = TRUE)
    ),
    
    # Main panel with leaflet map
    mainPanel(
      leafletOutput("map")
    )
  )
)