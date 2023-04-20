# Define server
server <- function(input, output){
  
  # Initialize map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = 0, lat = 0, zoom = 2)
  })
  
  # Add marker to map based on user selection
  observe({
    leafletProxy("map") %>%
      clearMarkers()
    if(!is.null(input$userLocation)){
      leafletProxy("map")%>%
        addMarkers(lng = input$userLocation[2], lat = input$userLocation[1],
                   label = "Your Location")
      for (loc in input$location){
        if(loc == "USA"){
          leafletProxy("map")%>%
            addMarkers(lng = -95.7129, lat = 37.0902,
                       label = "1. United States")
        } else if(loc == "Canada"){
          leafletProxy("map") %>%
            addMarkers(lng = -106.3468, lat = 56.1304,
                       label = "2. Canada")
        } else if(loc == "Mexico"){
          leafletProxy("map") %>%
            addMarkers(lng = -102.5528, lat = 23.6345,
                       label = "3. Mexico")
        } else if(loc == "Brazil"){
          leafletProxy("map") %>%
            addMarkers(lng = -51.9253, lat = -14.235,
                       label =  "4. Brazil")
        } else if(loc == "Argentina"){
          leafletProxy("map") %>%
            addMarkers(lng = -63.6167, lat = -38.4161,
                       label = "5. Argentina")
        } else if(loc == "UK"){
          leafletProxy("map") %>%
            addMarkers(lng = -0.1278, lat = 51.5074,
                       label =  "6. United Kingdom")
        } else if(loc == "France"){
          leafletProxy("map") %>%
            addMarkers(lng = 2.3522, lat = 48.8566,
                       label = "7. France")
        } else if(loc == "Germany"){
          leafletProxy("map") %>%
            addMarkers(lng = 10.4515, lat = 51.1657,
                       label =  "8. Germany")
        } else if(loc == "Italy"){
          leafletProxy("map") %>%
            addMarkers(lng = 12.5674, lat = 41.8719,
                       label = "9. Italy")
        } else if(loc == "Spain"){
          leafletProxy("map") %>%
            addMarkers(lng = -3.7492, lat = 40.4637,
                       label =  "10. Spain")
        } else if(loc == "China"){
          leafletProxy("map") %>%
            addMarkers(lng = 104.1954, lat = 35.8617,
                       label =  "11. China")
        } else if(loc == "Japan"){
          leafletProxy("map") %>%
            addMarkers(lng = 139.6503, lat = 35.6762,
                       label =  "12. Japan")
        }
      }
    }
    output$error <- renderPrint({ req(warnings())})
  })
  
  
  
  
  library(httr)
  library(opencage)
  # My API Key  
  api_key <- "5f7fdf784bd448468b0fac99bf0df5af"
  
  # Function to obtain the coordinates of a location using Opencagedata API.
  get_coordinates <- function(location, api_key) {
    url <- paste0("https://api.opencagedata.com/geocode/v1/json?q=", location, "&key=", api_key)
    response <- GET(url)
    data <- content(response)
    print(response) # Verify if a valid response is being received from the API
    print(data) #Verify the structure of the data in the response
    lat <- data$results[[1]]$geometry$lat
    lng <- data$results[[1]]$geometry$lng
    
    return(c(lat, lng))
  }
  
  # Function to calculate the distance between two points using Haversine's ecuation
  
  haversine <- function(lon1, lat1, lon2, lat2) {
    
    #convert degrees to radians
    
    lon1 <- lon1 * pi / 180
    lat1 <- lat1 * pi / 180
    lon2 <- lon2 * pi / 180
    lat2 <- lat2 * pi / 180
    
    #Calculate the differences between the points
    
    dlon <- lon2 - lon1
    dlat <- lat2 - lat1
    
    #Calculate de distance using  Harversine's Ecuation
    
    a <- sin(dlat / 2)^2 + cos(lat1) * cos(lat2) * sin(dlon / 2)^2
    c <- 2 * asin(sqrt(a))
    R <- 6371 # Earth's mean radius in KM
    d <- R * c
    
    return(d)
    
  }
  
  #Calculate best route when user clicks "Find Best route" Button
  
  observeEvent(input$goButto, {
    
    # Get user location
    user_locations <- input$userLocation
    
    #Get selected locations
    locations <- input$location
    
    # Get the coordinates of each location
    coordinates <- lapply(locations, function(x) get_coordinates(x, api_key))
    print(coordinates) # Verify if the coordinates are being obtained correctly
    
    # Add user location to coordinates
    coordinates <- c(list(user_locations), coordinates)
    
    
    #Calculate the distance matrix between the points
    
    n <- length(coordinates)
    dist_matrix <- matrix(nrow = n, ncol = n)
    for (i in 1:(n-1)) {
      for(j in (i+1):n){
        dist_matrix[i,j]<- haversine(coordinates[[i]][2], coordinates[[i]][1],
                                     coordinates[[j]][2], coordinates[[j]][1])
        dist_matrix[j,i] <- dist_matrix[i,j]
      }
    }
    
    print(dist_matrix) # Check if the distance matrix is being calculated correctly.
    
    # Check if the distance matrix contains NaN values
    
    if (sum(is.na(dist_matrix)) > 0) {
      
      #Find the location of the Nan values in the distance matrix
      
      nan_loc <- which(is.na(dist_matrix), arr.ind = TRUE)
      print(nan_loc)
      
    }
    
    #Set the values in the main diagonal of the distance matrix to zero
    diag(dist_matrix) <- 0
    
    # Create a network from the distance matrix
    
    library(igraph)
    grapho <- graph_from_adjacency_matrix(dist_matrix, mode =  "undirected", weighted = TRUE)
    
    
    # Calculate the shortest route between the user location  and the last selected location
    
    tour <- shortest_paths(grapho, from = 1, to = n)$vpath[[1]]
    print(tour) # Check if the shortest route is being calculated correctly
    
    #Show messages
    output$route <- renderText({
      req(tour)
      paste("The shorter route is : ", paste(c("Yosur Location", locations)[tour], collapse = "  =>  "))
    })
    
    
    
    #Add markers to the start and the end of points
    
    leafletProxy("map") %>%
      addCircleMarkers(lng = coordinates[[tour[1]]][2], lat = coordinates[[tour[1]]][1],
                       label = paste("Start:", locations[tour[1]])) %>%
      addCircleMarkers(lng = coordinates[[tour[length(tour)]]][2], lat =
                         coordinates[[tour[length(tour)]]][1],
                       label = paste("End:", locations[tour[length(tour)]]))
    
    
    #show the path on the map
    
    lngs <- c()
    lats <- c()
    
    for(i in 1:length(tour)) {
      
      lngs[i] <- coordinates[[tour[i]]][2]
      lats[i] <- coordinates[[tour[i]]][1]
      
      print(lngs)
      print(lats)
      print(tour)
      
    }
    
    leafletProxy("map") %>%
      addPolylines(lng = lngs,
                   lat = lats,
                   color = "red")
    
  })
}