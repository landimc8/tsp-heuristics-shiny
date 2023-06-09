
## COMPARAISON D'HEURISTIQUES: AIDE A LA DECISION


library(leaflet)
library(geosphere)

city1 = c("Paris", "Sydney", "Tokyo", "Toronto", "Los Angeles", "São Paulo", "Dubai", "Cairo", "Mumbai", "Hong Kong", "Rome","Yaoundé","La Paz", "Accra", "Cancún", "Natal", "Douala")

decision_with_map <- function(towns_list, seed_value =1240) {
  
  numb <- length(towns_list)
  
  long_lat_cities <- read.csv("~/Documents/GitHub/tsp-heuristics-shiny/worldcities.csv")
  head(long_lat_cities)
  
  long_lat_cities <- as.matrix(long_lat_cities)
  
  start <- c(long_lat_cities[, 3][long_lat_cities[, 1]==towns_list[1]], long_lat_cities[, 4][long_lat_cities[, 1]==towns_list[1]]) # Paris
  end <- c(long_lat_cities[, 3][long_lat_cities[, 1]==towns_list[1]], long_lat_cities[, 4][long_lat_cities[, 1]==towns_list[1]]) # Paris
  
  # Cities coordinates
  
  latus = c()
  longus = c()
  for (i in 1:numb) {
    
    lats = long_lat_cities[,3][long_lat_cities[,1]==towns_list[i]]
    latus[i]=lats[1]
    longs = long_lat_cities[,4][long_lat_cities[,1]==towns_list[i]]
    longus[i]=longs[1]
  }
  latus <- as.numeric(latus)
  longus <- as.numeric(longus)
  
  
  cities <- data.frame(towns_list, latus, longus)
  
  
  Mat_distance <- matrix(0,numb,numb)
  ptsmat <- t(cities[, c("longus", "latus")])
  
  for (i in 1:numb) {
    Mat_distance[i,] <- distHaversine(ptsmat[,i],t(ptsmat))
    
  }
  result = list()
  result1 = list()
  result2 = list()
  result3 = list()
  result4 = list()
  
  if (numb <= 40) {
    
    result1 = heurst_pvc_class_1(n=numb, sim=0, param1=parm1, param2=parm2, seed=seed_value, Matchoice=Mat_distance)
    result2 = heurst_pvc_class_2(n=numb, sim=0, param1=parm1, param2=parm2, seed=seed_value, Matchoice=Mat_distance)
    result3 = heurst_pvc_class_3(n=numb, sim=0, param1=parm1, param2=parm2, seed=seed_value, Matchoice=Mat_distance)
    result4 = heurst_pvc_class_4(n=numb, sim=0, param1=parm1, param2=parm2, seed=seed_value, Matchoice=Mat_distance)
    
    result = list(result1,result2,result3,result4)
    
    vect_result = c(result1[[1]],result2[[1]],result3[[1]],result4[[1]])
    
  }
  
  if (numb >= 41 && numb <= 80) {
    
    result1 = heurst_pvc_class_1(n=numb, sim=0, param1=parm1, param2=parm2, seed=seed_value, Matchoice=Mat_distance)
    result2 = heurst_pvc_class_2(n=numb, sim=0, param1=parm1, param2=parm2, seed=seed_value, Matchoice=Mat_distance)
    result3 = heurst_pvc_class_3(n=numb, sim=0, param1=parm1, param2=parm2, seed=seed_value, Matchoice=Mat_distance)
    result = list(result1,result2,result3)
    vect_result = c(result1[[1]],result2[[1]],result3[[1]])
    
  }
  
  if (numb >= 81 && numb <= 200) {
    
    result1 = heurst_pvc_class_1(n=numb, sim=0, param1=parm1, param2=parm2, seed=seed_value, Matchoice=Mat_distance)
    result2 = heurst_pvc_class_2(n=numb, sim=0, param1=parm1, param2=parm2, seed=seed_value, Matchoice=Mat_distance)
    result = list(result1,result2)
    vect_result = c(result1[[1]],result2[[1]])
    
  }
  
  
  if (numb >= 201) {
    
    result1 = heurst_pvc_class_1(n=numb, sim=0, param1=parm1, param2=parm2, seed=seed_value, Matchoice=Mat_distance)
    result = list(result1)
    vect_result = c(result1[[1]])
    
  }
  mn = min(vect_result)
  
  h <- which(vect_result[]==mn, arr.ind = TRUE)
  
  parc_chif<- result[[h[1]]][[2]][[1]]
  
  solut = c()
  for (j in 1:(numb+1)) {
    solut[j] = towns_list[parc_chif[j]]
  }
  
  # data.frame corresponding to the retained solution
  
  latitude = c()
  longitude = c()
  for (i in 1:(numb+1)) {
    
    latits = long_lat_cities[,3][long_lat_cities[,1]==solut[i]]
    latitude[i]=latits[1]
    longits = long_lat_cities[,4][long_lat_cities[,1]==solut[i]]
    longitude[i]=longits[1]
  }
  latitude <- as.numeric(latitude)
  longitude <- as.numeric(longitude)
  
  
  daf <- data.frame(latitude, longitude, solut, row.names = 1:length(latitude)) 
  
  return(list(solut, daf, mn, h, result[[h[1]]], Mat_distance))
  
}



verif=decision_with_map(towns_list = city1, seed_value = 1240)
verif



city1 = c("Paris", "Sydney", "Tokyo", "Toronto", "Los Angeles", "São Paulo", "Dubai", "Cairo", "Mumbai", "Hong Kong")

latits = c(48.8566, -33.8688, 35.6762, 43.6532, 34.0522, -23.5505, 25.2048, 30.0444, 19.0760, 22.3193)
longits = c(2.3522, 151.2093, 139.6503, -79.3832, -118.2437, -46.6333, 55.2708, 31.2357, 72.8777, 114.1694)

#  sim_param_default <- matrix(c(7,7,1,4,10,0.85, 0.21,0.21,5,5,4,17,50,225), nrow=2, ncol=7, byrow=FALSE)
#  sim_param= t(sim_param_default)
#  sim_param[,2][sim_param[,1]==1]

library(geosphere)

towns_list = city1

numb = length(towns_list)

long_lat_cities <- read.csv("~/Documents/GitHub/tsp-heuristics-shiny/worldcities.csv")
head(long_lat_cities)

long_lat_cities <- as.matrix(long_lat_cities)

start <- c(long_lat_cities[, 3][long_lat_cities[, 1]==towns_list[1]], long_lat_cities[, 4][long_lat_cities[, 1]==towns_list[1]]) # Paris
end <- c(long_lat_cities[, 3][long_lat_cities[, 1]==towns_list[1]], long_lat_cities[, 4][long_lat_cities[, 1]==towns_list[1]]) # Paris

# Cities Coordinates.

latus = c()
longus = c()
for (i in 1:numb) {
  
  lats = long_lat_cities[,3][long_lat_cities[,1]==towns_list[i]]
  latus[i]=lats[1]
  longs = long_lat_cities[,4][long_lat_cities[,1]==towns_list[i]]
  longus[i]=longs[1]
}

cities = data.frame(towns_list, latus, longus)

Mat_distance = matrix(0,numb,numb)
ptsmat <- t(cities[, c("longus", "latus")])

for (i in 1:numb) {
  Mat_distance[i,] <- distHaversine(ptsmat[,i],t(ptsmat))
  
}



