
# Define UI
ui <- fluidPage(
  titlePanel("Pin a Location on the Map"),
  leafletOutput("map"),
  selectInput("location", "Select a Location:",
              c("USA", "Canada", "Mexico", "Brazil", "Argentina",
                "UK", "France", "Germany", "Italy", "Spain",
                "China", "Japan", "India", "Australia", "New Zealand",
                "Tokyo", "New York", "London", "Paris", "Berlin"))
)