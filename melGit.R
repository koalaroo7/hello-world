Melbourne_housing_FULL <- read.csv("~/Desktop/Melbourne data project/melbourne-housing-market/Melbourne_housing_FULL.csv")

melHouse <- Melbourne_housing_FULL

# check NA

colSums(is.na(melHouse))
