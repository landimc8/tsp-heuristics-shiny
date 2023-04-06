

# Define server
# Define server
server <- function(input, output, session) {
  
  # Initialize map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = 0, lat = 0, zoom = 2)
  })
  
  # Add marker to map based on user selection
  observe({
    if(input$location == "USA"){
      leafletProxy("map") %>%
        clearMarkers() %>%
        addMarkers(lng = -95.7129, lat = 37.0902,
                   popup = "United States")
    } else if(input$location == "Canada"){
      leafletProxy("map") %>%
        clearMarkers() %>%
        addMarkers(lng = -106.3468, lat = 56.1304,
                   popup = "Canada")
    } else if(input$location == "Mexico"){
      leafletProxy("map") %>%
        clearMarkers() %>%
        addMarkers(lng = -102.5528, lat = 23.6345,
                   popup = "Mexico")
    } else if(input$location == "Brazil"){
      leafletProxy("map") %>%
        clearMarkers() %>%
        addMarkers(lng = -51.9253, lat = -14.235,
                   popup = "Brazil")
    } else if(input$location == "Argentina"){
      leafletProxy("map") %>%
        clearMarkers() %>%
        addMarkers(lng = -63.6167, lat = -38.4161,
                   popup = "Argentina")
    } else if(input$location == "UK"){
      leafletProxy("map") %>%
        clearMarkers() %>%
        addMarkers(lng = -0.1278, lat = 51.5074,
                   popup = "United Kingdom")
    } else if(input$location == "France"){
      leafletProxy("map") %>%
        clearMarkers() %>%
        addMarkers(lng = 2.3522, lat = 48.8566,
                   popup = "France")
    } else if(input$location == "Germany"){
      leafletProxy("map") %>%
        clearMarkers() %>%
        addMarkers(lng = 10.4515, lat = 51.1657,
                   popup = "Germany")
    } else if(input$location == "Italy"){
      leafletProxy("map") %>%
        clearMarkers() %>%
        addMarkers(lng = 12.5674, lat = 41.8719,
                   popup = "Italy")
    } else if(input$location == "Spain"){
      leafletProxy("map") %>%
        clearMarkers() %>%
        addMarkers(lng = -3.7492, lat = 40.4637,
                   popup = "Spain")
    } else if(input$location == "China"){
      leafletProxy("map") %>%
        clearMarkers() %>%
        addMarkers(lng = 104.1954, lat = 35.8617,
                   popup = "China")
    } else if(input$location == "Japan"){
      leafletProxy("map") %>%
        clearMarkers() %>%
        addMarkers(lng = 139.6503, lat = 35.6762,
                   popup = "Japan")
    }
  })
  }

