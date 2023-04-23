# Traveling Salesman Problem (TSP) - Heuristics Comparison Project

Visit the app at https://tsp-heuristics.shinyapps.io/my_app/?_ga=2.181066471.1599980475.1682259606-1457063969.1679223089

This study compares the effectiveness of various heuristics for the Traveling Salesman Problem solution. (TSP). The greedy heuristic is the primary emphasis, and we introduce new iterations of this algorithm to see if they can enhance its performance.

# Background

The TSP comprises finding the shortest path that only makes one pass through each of the n points. From logistics and transit to circuit design and DNA sequencing, this issue is pertinent in many different fields. In reality, heuristic algorithms are frequently used to handle this issue because exact solutions can be extremely computationally expensive.
By selecting the option that optimizes the current value of the objective function at each stage, the greedy heuristic constructs a solution step by step. This type of heuristic is used in the nearest neighbor algorithm, where the non-visited city closest to the traveler's present location is selected as the next step. However, this algorithm has myopia, which means it could become stuck in a less-than-ideal answer.

# Objective

In this project, we suggest examining fresh iterations of the greedy heuristic that recast the goal function in order to lessen its myopia. Depending on how many following places the objective function must take into account, we refer to these variations as class c greedy heuristics for TSP. We will implement the new class 2, 3, and 4 heuristics as well as the nearest neighbor algorithm (class 1), and compare how well they work.
Our primary goal is to investigate the theories that:

* The greedy heuristics of even classes are comparatively more effective than those of odd classes for an even number of towns, according to hypothesis 1.
* The greedy heuristics of odd classes are comparatively more effective than those of even classes for an odd number of cities.

# Implementation

In order to evaluate various heuristics for a smaller set of cities, we implemented the class 1 greedy heuristic in the R programming language. The tables in the preceding section display the results.
The class 2, 3, and class 4 greedy algorithms will then be programmed, and a package will be created. We will also have the chance to expand our understanding of the R programming language.

# Results

According to empirical findings thus far, an even class heuristic offers the best answer for more than 80% of the sample's even occurrences, while an odd class heuristic does so for more than 60% of the sample's odd occurrences. We hypothesize that these ratios rise as the TSP occurrence's magnitude rises.

# Conclusion

Understanding the advantages and disadvantages of these algorithms can be improved by implementing the class c greedy strategies for TSP and evaluating their performance. The obtained findings can also serve as a guide when choosing the best heuristic for a particular TSP problem size and structure.

# Authors
Anouk Xabina Lhote, Imen Hassine, Miguel Romero Montoya and Zildete Landim Crausaz

# License
This project is licensed under the MIT License.
