# Le script du Shiny Project 2023 -----------------------------------------------------------------

library(shiny)
library(shinyMatrix)
library(htmltools)
library(dplyr)
library(leaflet)
library(geosphere)
library(shinythemes)


long_lat_cities <- vroom::vroom("~/Documents/GitHub/tsp-heuristics-shiny/worldcities.csv", col_types = list())
long_lat_cities_arr<- long_lat_cities %>%
  arrange(city)

cities_countries<- long_lat_cities_arr %>%
  select(city,admin_name, country)

ui <- fluidPage(theme = shinytheme("cerulean"),
                
                headerPanel("The Traveling Salesman Problem"),
                headerPanel("Part I: Decision Support"),
                
                sidebarPanel(
                  selectInput("citychoices", "Alternative 1: Choice of cities to visit",
                              c("Paris", "Sydney", "Los Angeles", "São Paulo",
                                "Dubai", "Cairo","Yaoundé","La Paz",
                                "Accra", "Cancún", "Natal", "Douala"),
                              choices = cities_countries$city[1:50000], multiple=TRUE),
                  matrixInput("w","Alternative 2: Choice of distance matrix",
                              matrix(c(2, 2, 1, 2, 4, 5, 1, 3, 1, 3, 4, 4, 2, 2, 2, 2, 7, 2, 3, 5, 1, 1, 3, 7, 4, 4, 6, 3, 4, 2, 1, 2, 7, 3, 2, 2,
                                       4, 1, 1, 2, 4, 2, 7, 5, 3, 2, 3, 3, 3, 3, 1, 5, 3, 6, 2, 1, 1, 6, 4, 4, 4, 5, 2, 3, 7, 2, 3, 4, 5, 5, 3, 2,
                                       3, 2, 6, 5, 1, 2, 1, 2, 1, 2, 4, 3, 5, 4, 4, 2, 4, 2, 1, 1, 4, 5, 3, 2, 2, 5, 2, 2, 4, 5, 3, 4, 2, 3, 3, 1,
                                       3, 4, 4, 5, 4, 3, 2, 1, 2, 4, 5, 4, 1, 7, 1, 6, 5, 3, 2, 3, 1, 4, 5, 3, 4, 1, 1, 3, 4, 2, 2, 5, 5, 2, 2, 4,
                                       6, 7, 4, 4, 5, 1, 4, 4, 4, 1, 3, 4, 4, 1, 5, 7, 2, 2, 4, 1, 6, 4, 6, 2, 1, 2, 4, 5, 2, 3, 4, 2, 1, 2, 3, 7,
                                       2, 3, 7, 6, 3, 2, 3, 4, 4, 4, 4, 2, 7, 5, 1, 2, 4, 5, 4, 2, 4, 4, 5, 1, 5, 1, 3, 5, 4, 3, 2, 2, 3, 4, 6, 2,
                                       2, 4, 1, 1, 6, 7, 1, 3, 7),nrow=15,ncol=15,byrow = FALSE),
                              class="numeric", rows = list(names = FALSE), cols = list(names = FALSE)),
                  numericInput("n_t","Number of towns to visit :", 12),
                  #  actionButton("Execute", "Let's optimize the distance", icon = icon("thumbs-up"))
                ),
                
                mainPanel(
                  h3("Alternative 1 Solution"),
                  tabsetPanel(
                    tabPanel("The illustrative map for alternative 1", leafletOutput("map_journey")),
                    tabPanel("Optimal Journey for alternative 1", verbatimTextOutput("Optimal_Journey_1")),
                    tabPanel("Minimal distance for alternative 1", verbatimTextOutput("min_dist_1")),
                  ),
                  h3("Alternative 2 Solution"),
                  tabsetPanel(
                    tabPanel("Optimal Journey for alternative 2", verbatimTextOutput("Optimal_Journey_2")),
                    tabPanel("Minimal distance for alternative 2", verbatimTextOutput("min_dist_2")),
                  )
                ),
                headerPanel("Part II: Research Assistance"),
                sidebarPanel(
                  matrixInput("sparam","Simulation law parameters",
                              matrix(c(6,5,1,4,9,0.69, 0.43,0.17,5,5,4,17,47,121),
                                     nrow=2, ncol=7, byrow=FALSE, dimnames = list(c("pm1", "pm2"),
                                                                                  c("rpois", "runf", "rbin", "rexp", "rch2", "rf", "|rnrm|"))),
                              class="numeric"),
                  numericInput("sdval","seed", 22440),
                  matrixInput("hm","Number of cities between 2(h+3) and 2(m+2)+1",
                              matrix(c(0,5), nrow=1, ncol=2, byrow=TRUE,
                                     dimnames = list("1",c("h","m")))),
                ),
                
                mainPanel(
                  h3("Joint Effects of Parity and Myopia"),
                  tabsetPanel(
                    tabPanel("Even classes versus odd classes", tableOutput("perct"),
                             textOutput("inter_parity1_g"),
                             textOutput("inter_parity2_g")),
                    tabPanel("Class 2 versus class 1", tableOutput("perct21"),
                             textOutput("inter_parity1_21"),
                             textOutput("inter_parity2_21")),
                    tabPanel("Class 4 versus class 3", tableOutput("perct43"),
                             textOutput("inter_parity1_43"),
                             textOutput("inter_parity2_43")),
                    tabPanel("Class 4 versus class 1", tableOutput("perct41"),
                             textOutput("inter_parity1_41"),
                             textOutput("inter_parity2_41")),
                    tabPanel("Class 3 versus class 2", tableOutput("perct32"),
                             textOutput("inter_parity1_32"),
                             textOutput("inter_parity2_32")),
                    tabPanel("Interpretations of parity tests",
                             textOutput("inter_parity_1"),
                             textOutput("inter_parity_2"),
                             textOutput("inter_parity_3")),
                  ),
                  
                  h3("Pure Effects of Myopia"),
                  tabsetPanel(
                    tabPanel("Classe 4 and 3 versus classe 1 and 2",
                             tableOutput("perctm"),
                             textOutput("inter_myopia1_mg"),
                             textOutput("inter_myopia2_mg")),
                    tabPanel("Class 3 versus class 1", tableOutput("perct31"),
                             textOutput("inter_myopia1_31"),
                             textOutput("inter_myopia2_31")),
                    tabPanel("Class 4 versus class 2", tableOutput("perct42"),
                             textOutput("inter_myopia1_42"),
                             textOutput("inter_myopia2_42")),
                    tabPanel("Interpretations of myopia tests",
                             textOutput("inter_myopia_1"),
                             textOutput("inter_myopia_2"),
                             textOutput("inter_myopia_3")),
                  )
                )
)

