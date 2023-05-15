<h1 align="center">Travelling Salesman Problem (TSP) - Heuristics Comparison Project ✈️🧳🧭🗺️</h1>

This study compares the effectiveness of various heuristics for the Travelling Salesman Problem solution. (TSP). The greedy heuristic is the primary emphasis, and we introduce new iterations of this algorithm to see if they can enhance its performance.

<br>

<div align="center">

  <a href="https://opensource.org/licenses/MIT">![License](https://img.shields.io/badge/License-MIT-yellow)</a>
  <a href="https://www.r-project.org/about.html">![Language](https://img.shields.io/badge/Language-R-blue)</a>
  <a href="https://tsp-heuristics.shinyapps.io/tsp-heuristics/">![Demo](https://img.shields.io/badge/App-Demo-indigo)</a>
</div>

<br>

<div align="center">
    
[![image.png](https://i.postimg.cc/LsQ5gT8X/image.png)](https://postimg.cc/WDrTQ0rL)
  
</div>

<br>
<br>


<h1 align="center">Installation ⬇️</h1>

## Prequisities

<br>

Before proceeding, ensure that you have the following:

<br>

1. R and RStudio installed on your machine
2. The necessary R packages installed, including Shiny and any additional packages required by the scripts

### Required Packages 📦:

<br>

`library(shiny)`
`library(shinyMatrix)`
`library(htmltools)`
`library(dplyr)`
`library(leaflet)`
`library(geosphere)`
`library(shinythemes)
<br>

Please make sure to install the required packages before running the Shiny app.


## Installation and Setup

<br>

1. Download all the scripts related to this draft version of the Shiny app. 
2. Create a new directory for your Shiny project in RStudio. 
3. Move all the downloaded scripts into this directory.

<br>

## Execution Order

<br>

To properly run the Shiny app, execute the scripts in the following order:
1. `Heurst_PVC_Class_1.R`
2. `Heurst_PVC_Class_2.R`
3. `Heurst_PVC_Class_3.R`
4. `Heurst_PVC_Class_4.R`
5. `comparisons.R`
6. `decision.R` 
7. `function_cart_graph.R`
8. `decision_with_map.R `
9. `TSP.R` (Run this script last)

## Running the Shiny App

<br>

1. Once all the scripts have been executed successfully, locate and open the TSP.R script.
2. Run the TSP.R script and wait for approximately 2 minutes.
3. The Shiny app will progressively load and display a map, itinerary, and statistical tables for testing and comparing the heuristics used.

## To install the package 📦


```
library(devtools)

install_github("landimc8/tspHeuris")
```

<br>

## To load the Package 📦


```library(tspHeuris)```

<br>

## To run the app


```runMyApp()```

<br>

A map, itinerary, and statistics tables will be gradually loaded and displayed in the Shiny app for evaluating and contrasting the heuristics employed.

## Using the Shiny App

- Explore the map: Interact with the map to view different locations and routes. 
- Itinerary: Check the generated itinerary for the selected route. 
- Statistical Tables: Analyze the statistical information and comparisons between the various heuristics. 
- Make any necessary selections or inputs within the app to customize your experience.

Please note that this guide assumes basic familiarity with R and RStudio. If you encounter any issues or have further questions, refer to the documentation for the Shiny package or consult the developer of the Shiny app for assistance.


<br>

<h1 align="center">Background 🌇</h1>
The Traveling Salesman Problem (TSP) involves finding the shortest path that visits each of the given points exactly once. It is a relevant problem in various fields such as logistics, transit, circuit design, and DNA sequencing. Due to the high computational complexity of finding exact solutions, heuristic algorithms are often employed. One such heuristic is the greedy approach, which constructs a solution incrementally by choosing the option that optimizes the objective function at each step. For example, the nearest neighbor algorithm selects the unvisited city closest to the current location as the next step. However, this algorithm may suffer from myopia and get stuck in suboptimal solutions.

<br>

<h1 align="center">Objective 🔭</h1>
In this project, we propose exploring updated versions of the greedy heuristic to reduce its myopia. These variations, known as class c greedy heuristics for TSP, redefine the objective function to consider a certain number of subsequent locations. We will implement class 1 (nearest neighbor algorithm), as well as the new class 2, 3, and 4 heuristics. Our main objective is to examine the hypotheses that:

<br>
<br>

- The greedy heuristics of even classes are comparatively more effective than those of odd classes for an even number of towns, according to hypothesis 1.
- The greedy heuristics of odd classes are comparatively more effective than those of even classes for an odd number of cities.

<h1 align="center">Implementation ✍🏼</h1>
To evaluate different heuristics for a smaller set of cities, we implemented the class 1 greedy heuristic using the R programming language. The results are shown in the tables mentioned earlier. Next, we will proceed to implement the class 2, 3, and class 4 greedy algorithms and create a package. This process will further enhance our knowledge and proficiency in the R programming language.

<h1 align="center">Results 📰</h1>
Based on empirical findings to date, it has been observed that an even class heuristic provides the best solution for over 80% of the sample's even occurrences, while an odd class heuristic achieves this for more than 60% of the sample's odd occurrences. We hypothesize that these ratios will increase as the magnitude of the TSP instances increases.

<h1 align="center">Conclusions ✋🏼</h1>
Implementing the class c greedy strategies for TSP and evaluating their performance can enhance our understanding of the advantages and disadvantages of these algorithms. The findings obtained from such evaluations can serve as a valuable guide when selecting the most suitable heuristic for a given TSP problem, considering factors such as problem size and structure. This empirical analysis will contribute to making informed decisions regarding heuristic selection in TSP problem-solving scenarios.


<br>

<h1 align="center">Authors 👩🏻👩🏼👨🏽👩🏻</h1>

<br>

<div align="center">
  
Anouk Xabina Lhote 
<br>
Imen Hassine
  <br>
Miguel Romero Montoya
  <br>
Zildete Landim Crausaz
  <br>
  
</div>

Enjoy using the Shiny app!

