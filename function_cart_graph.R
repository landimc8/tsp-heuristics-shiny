

library(leaflet)
library(geosphere)


# Define the start and end points

long_lat_cities=read.csv("~/Statistical Modeling 22/travail/worldcities.csv")
head(long_lat_cities)

start <- c(40.7128, -74.0060) # New York City
end <- c(40.7128, -74.0060) # New York City

# Define the additional cities
cities <- data.frame(
  city = c("Paris", "Sydney", "Tokyo", "Toronto", "Los Angeles", "São Paulo", "Dubai", "Cairo", "Mumbai", "Hong Kong"),
  lat = c(48.8566, -33.8688, 35.6762, 43.6532, 34.0522, -23.5505, 25.2048, 30.0444, 19.0760, 22.3193),
  lon = c(2.3522, 151.2093, 139.6503, -79.3832, -118.2437, -46.6333, 55.2708, 31.2357, 72.8777, 114.1694)
)

# Calculate the great circle distances between the start and end points and the additional cities

ptsmat <- cbind(start[1:2], t(cities[, c("lon", "lat")]))

distances <- distHaversine(t(ptsmat))[1:10]
# colnames(distances) <- cities$city
distances["London"] <- distHaversine(end, cities[, c("lon", "lat")])

# Print the distances
print(distances)

# Create a data frame with the start, end, and additional cities
df <- rbind(
  data.frame(lat = c(start[1], end[1]), lon = c(start[2], end[2]), city = c("Start", "End")),
  data.frame(lat = cities$lat, lon = cities$lon, city = cities$city)
)

# Function that create a map centered on the start point

function_cart_graph <- function(datf) {
  
  m <- leaflet(datf) %>%
    addTiles() %>%
    setView(lng = mean(as.numeric(datf[,2])), lat = mean(as.numeric(datf[,1])), zoom = 2)
  
  # Add markers for the start, end, and additional cities
  m <- m %>%
    addCircleMarkers(data = datf, label = ~datf[,3])
  
  # Create lines between the start and end points and the additional cities
  m <- m %>%
    addPolylines(lat = datf[,1], lng = datf[,2])
  
  # Print the map
  return(m)
}

df

function_cart_graph(datf=df)


# matx_distance -----------------------------------------------------------

distance_mat <- matrix(0,11,11)
ptsmat <- cbind(start[1:2], t(cities[, c("lon", "lat")]))

for (i in 1:11) {
  distance_mat[i,] <- distHaversine(ptsmat[,i],t(ptsmat))
  
}


distance_mat


