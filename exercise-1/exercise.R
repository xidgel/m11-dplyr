# Exercise 1: Data Frame Practice

# Install devtools package: allows installations from GitHub
# install.packages('devtools')

# Install "fueleconomy" package from GitHub
# devtools::install_github("hadley/fueleconomy")

# Require/library the fueleconomy package
library(fueleconomy)

# You should have have access to the `vehicles` data.frame
vehicles.df <- data.frame(vehicles, stringsAsFactors = FALSE)

# Create a data.frame of vehicles from 1997
vehicles.1997 <- data.frame(vehicles.df[vehicles.df$year==1997, ])

# Use the `unique` function to verify that there is only 1 value in the `year` column of your new data.frame
unique(vehicles.1997$year)

# Create a data.frame of 2-Wheel Drive vehicles that get more than 20 miles/gallon in the city
vehicles.2wd.20mpgcty <- vehicles.df[vehicles.df$drive=="2-Wheel Drive" & vehicles.df$cty > 20, ]

# Of those vehicles, what is the vehicle ID of the vehicle with the worst hwy mpg?
min.hwy.mileage <- min(vehicles.2wd.20mpgcty$hwy)
worst.hwy.mileage.id <- vehicles.2wd.20mpgcty[vehicles.2wd.20mpgcty$hwy == min.hwy.mileage, ]$id
paste("The id of the 2wd vehicle that gets the worst hwy mileage but at least 20 mpg city is", worst.hwy.mileage.id)

# Write a function that takes a `year` and a `make` as parameters, and returns 
# The vehicle that gets the most hwy miles/gallon of vehicles of that make in that year
BestHwyMPG <- function(year, make) {
  vehicles.year.make <- vehicles[vehicles$year == year & vehicles$make == make, ]
  max.hwy.mileage <- max(vehicles.year.make$hwy)
  max.hwy.vehicles <- vehicles.year.make[vehicles.year.make$hwy == max.hwy.mileage, ]
  return(max.hwy.vehicles)
}

# What was the most efficient honda model of 1995?
BestHwyMPG(1995, "Honda")

