library(tidyverse)

list.files("data")

# reading in RData file and writing out as CSV
hobbs_flagler <- read_csv("data/hobbs_flagler_unique.csv")
write_csv(flagged, "data/flagged.csv", na="")