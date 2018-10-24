Melbourne_housing_FULL <- read_csv("~/Desktop/Melbourne data project/melbourne-housing-market/Melbourne_housing_FULL.csv")

melHouse <- Melbourne_housing_FULL 
library(tidyverse)

# view entire dataset
View(melHouse)
# inpect the first 6 rows
head(melHouse)
melHouse <- as.tibble(melHouse)

# check the structure and summary 
str(melHouse)
summary(melHouse)

# Longitude and Latitue are spelled incorrectly changing column name

melHouse %>% 
  rename("Lat" = "Lattitude")

summary(melHouse)
colnames(melHouse)
View(melHouse)


# inspecting NA values
library(Amelia)
missmap(melHouse)

colSums(is.na(melHouse))

count(melHouse, is.na(Bathroom))

# inspecting rooms vs bedroom2 as Bedroom2 was scraped from a different source

melHouse %>%
  select(Rooms, Bedroom2)

# inspecting the rows that are not equal to each other
melHouse %>%
  select(Rooms, Bedroom2) %>%
  filter(Rooms != Bedroom2)

# getting a count of how many rows containt the same values
melHouse %>%
  select(Rooms, Bedroom2) %>%
  count(Rooms == Bedroom2)

# checking the correlation
cor.test(melHouse$Rooms, melHouse$Bedroom2)

# Dropping Bedroom2 due to multicolinearity issues
melHouse2 <- select(melHouse, -Bedroom2, 'Lat' = 'Lattitude', 'Long' = 'Longtitude')

#inspecting data to be sure Bedroom2 is removed
View(melHouse2)


#-------------------

melHouseClean <- select(melHouse2, - SellerG, - Method, - Propertycount, - Suburb, - Address)

melHouseClean$Regionname <- as.character(melHouseClean$Regionname)

unique(melHouseClean$Regionname)
melHouseClean$Regionname[melHouseClean$Regionname == 'Northern Metropolitan'] = '1'
melHouseClean$Regionname[melHouseClean$Regionname == 'Western Metropolitan'] = '2'
melHouseClean$Regionname[melHouseClean$Regionname == 'Southern Metropolitan'] = '3'
melHouseClean$Regionname[melHouseClean$Regionname == 'Eastern Metropolitan'] = '4'
melHouseClean$Regionname[melHouseClean$Regionname == 'Eastern Victoria'] = '5'
melHouseClean$Regionname[melHouseClean$Regionname == 'Northern Victoria'] = '6'
melHouseClean$Regionname[melHouseClean$Regionname == 'Western Victoria'] = '7'

melHouseClean %>%
  filter(Regionname == '#N/A')


# TO DO LIST

#regionName = property count directly, drop columns and factor region

# change year built to a fact or 1,2,3,4 for the four seasons
# delete postcode & address as it is in relation to suburb
# delete real estate agent
# separate types or make them a factor???
# delete method

summary(melHouse$Suburb)
# inspecting the amount of distinct suburbs
unique(melHouse2$Suburb)
# delete suburbs and use lattitude and longitude

unique(melHouse2$Regionname) # keep region name and delete all other address info

unique(melHouse2$CouncilArea)


