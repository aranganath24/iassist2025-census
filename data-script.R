library(tidycensus)
setwd("/Users/adra7980/Library/CloudStorage/OneDrive-UCB-O365/Desktop/git-repositories/iassist2025-census/episodes/data")

decennial_variables_2010<-load_variables(2010, "sf1")

write_csv(decennial_variables_2010, "episodes/data/decennial_variables_2010.csv")

getwd()